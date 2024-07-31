defmodule UiWeb.TabsLive do
  @moduledoc false

  alias UI.Tabs

  alias Ui.Resources.Resource1

  alias Phoenix.LiveView.{JS, AsyncResult}

  use UiWeb, :live_view

  def mount(_params, _session, socket) do
    form = Resource1 |> AshPhoenix.Form.for_create(:create) |> to_form()

    socket =
      socket
      |> assign(data: AsyncResult.loading())
      |> assign(form: form)

    {:ok, socket}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_event("validate", %{"form" => params}, socket) do
    %{form: form} = socket.assigns

    form = AshPhoenix.Form.validate(form, params)

    {:noreply, assign(socket, form: form)}
  end

  def handle_event("submit", %{"form" => params}, socket) do
    %{form: form} = socket.assigns

    AshPhoenix.Form.submit(form, params: params)

    {:noreply, socket}
  end

  def handle_event("load_shit", _, socket) do
    {:noreply, start_async(socket, :data, &load_shit/0)}
  end

  def handle_event("reset_shit", _, %{assigns: %{data: %{ok?: true}}} = socket),
    do: {:noreply, assign(socket, data: AsyncResult.loading())}

  def handle_event("reset_shit", _, %{assigns: %{data: %{loading: true}}} = socket),
    do: {:noreply, cancel_async(socket, :data, :reset)}

  def handle_event("reset_shit", _, socket),
    do: {:noreply, assign(socket, data: AsyncResult.loading())}

  def handle_async(:data, {:ok, fetched_data}, socket) do
    %{data: data} = socket.assigns

    {:noreply, assign(socket, data: AsyncResult.ok(data, fetched_data))}
  end

  def handle_async(:data, {:exit, :reset}, socket),
    do: {:noreply, assign(socket, data: AsyncResult.loading())}

  def handle_async(:data, {:exit, reason}, socket) do
    %{data: data} = socket.assigns

    {:noreply, assign(socket, data: AsyncResult.failed(data, {:exit, reason}))}
  end

  def render(assigns) do
    ~H"""
    <.tabs live_action={@live_action} />
    <.tabs_contents live_action={@live_action} data={@data} form={@form} />
    """
  end

  defp tabs(assigns) do
    ~H"""
    <Tabs.tabs>
      <Tabs.tab
        id="profile_tab"
        content_id="profile_content"
        mount_selected?={@live_action == :index}
        on_selected={JS.patch(~p"/tabs")}
      >
        Profile
      </Tabs.tab>

      <Tabs.tab
        id="load_shit_tab"
        content_id="load_shit_content"
        mount_selected?={@live_action == :load_shit}
        on_selected={JS.patch(~p"/tabs/load_shit") |> JS.push("load_shit")}
        on_unselected={JS.push("reset_shit")}
      >
        Load Shit
      </Tabs.tab>

      <Tabs.tab
        id="with_form_tab"
        content_id="with_form_content"
        mount_selected?={@live_action == :with_form}
        on_selected={JS.patch(~p"/tabs/with_form")}
      >
        With Form
      </Tabs.tab>
    </Tabs.tabs>
    """
  end

  defp tabs_contents(assigns) do
    ~H"""
    <Tabs.contents>
      <Tabs.content id="profile_content" tab_id="profile_tab" mount_selected?={@live_action == :index}>
        <p class="text-sm text-gray-500 dark:text-gray-400">
          This is some placeholder content the <strong class="font-medium text-gray-800 dark:text-white">Profile tab's associated content</strong>. Clicking another tab will toggle the visibility of this one for the next. The tab JavaScript swaps classes to control the content visibility and styling.
        </p>
      </Tabs.content>

      <Tabs.content
        id="load_shit_content"
        tab_id="load_shit_tab"
        mount_selected?={@live_action == :load_shit}
      >
        <.async_result :let={_data} assign={@data}>
          <:loading>
            <div
              role="status"
              class="space-y-8 animate-pulse md:space-y-0 md:space-x-8 rtl:space-x-reverse md:flex md:items-center"
            >
              <div class="flex items-center justify-center w-full h-48 bg-gray-300 rounded sm:w-96 dark:bg-gray-700">
                <svg
                  class="w-10 h-10 text-gray-200 dark:text-gray-600"
                  aria-hidden="true"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="currentColor"
                  viewBox="0 0 20 18"
                >
                  <path d="M18 0H2a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2Zm-5.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3Zm4.376 10.481A1 1 0 0 1 16 15H4a1 1 0 0 1-.895-1.447l3.5-7A1 1 0 0 1 7.468 6a.965.965 0 0 1 .9.5l2.775 4.757 1.546-1.887a1 1 0 0 1 1.618.1l2.541 4a1 1 0 0 1 .028 1.011Z" />
                </svg>
              </div>
              <div class="w-full">
                <div class="h-2.5 bg-gray-200 rounded-full dark:bg-gray-700 w-48 mb-4"></div>
                <div class="h-2 bg-gray-200 rounded-full dark:bg-gray-700 max-w-[480px] mb-2.5"></div>
                <div class="h-2 bg-gray-200 rounded-full dark:bg-gray-700 mb-2.5"></div>
                <div class="h-2 bg-gray-200 rounded-full dark:bg-gray-700 max-w-[440px] mb-2.5"></div>
                <div class="h-2 bg-gray-200 rounded-full dark:bg-gray-700 max-w-[460px] mb-2.5"></div>
                <div class="h-2 bg-gray-200 rounded-full dark:bg-gray-700 max-w-[360px]"></div>
              </div>
              <span class="sr-only">Loading...</span>
            </div>
          </:loading>

          <:failed :let={_failure}>There was an error loading the data</:failed>

          <p class="text-sm text-gray-500 dark:text-gray-400">
            This is some placeholder content the <strong class="font-medium text-gray-800 dark:text-white">Dashboard tab's associated content</strong>. Clicking another tab will toggle the visibility of this one for the next. The tab JavaScript swaps classes to control the content visibility and styling.
          </p>
        </.async_result>
      </Tabs.content>

      <Tabs.content
        id="with_form_content"
        tab_id="with_form_tab"
        mount_selected?={@live_action == :with_form}
      >
        <.form :let={f} id="my_form" for={@form} phx-submit="submit" phx-change="validate">
          <!-- Modal body -->
          <div class="p-4 md:p-5 space-y-4">
            <.input type="text" field={f[:name]} placeholder="name" />
            <.input type="text" field={f[:type]} placeholder="type" />
          </div>
          <!-- Modal footer -->
          <div class="flex items-center p-4 md:p-5 border-t border-gray-200 rounded-b dark:border-gray-600">
            <button
              type="submit"
              class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
            >
              Submit
            </button>
          </div>
        </.form>
      </Tabs.content>
    </Tabs.contents>
    """
  end

  defp load_shit do
    Process.sleep(3_000)

    %{text: "blibs"}
  end
end
