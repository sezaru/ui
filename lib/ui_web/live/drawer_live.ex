defmodule UiWeb.DrawerLive do
  @moduledoc false

  alias UI.{Drawer, Button}

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
    <.drawer_loading_data live_action={@live_action} data={@data} />
    <br />
    <.drawer_with_restoring_form live_action={@live_action} form={@form} />
    """
  end

  defp drawer_with_restoring_form(assigns) do
    ~H"""
    <Button.base phx-click={Drawer.show("drawer_2")}>Drawer with restoring form</Button.base>

    <Drawer.base
      id="drawer_2"
      closable?={true}
      mount_showing?={@live_action == :drawer_2}
      on_hide={JS.patch(~p"/drawer")}
      on_show={JS.patch(~p"/drawer/open_2")}
    >
      <h5
        id="drawer-label"
        class="inline-flex items-center mb-4 text-base font-semibold text-gray-500 dark:text-gray-400"
      >
        <svg
          class="w-4 h-4 me-2.5"
          aria-hidden="true"
          xmlns="http://www.w3.org/2000/svg"
          fill="currentColor"
          viewBox="0 0 20 20"
        >
        <path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z" />
      </svg>Info
      </h5>
      <button
        type="button"
        phx-click={Drawer.hide("drawer_2")}
        class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 absolute top-2.5 end-2.5 flex items-center justify-center dark:hover:bg-gray-600 dark:hover:text-white"
      >
        <svg
          class="w-3 h-3"
          aria-hidden="true"
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 14 14"
        >
          <path
            stroke="currentColor"
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"
          />
        </svg>
        <span class="sr-only">Close menu</span>
      </button>

      <p class="mb-6 text-sm text-gray-500 dark:text-gray-400">
        <.form :let={f} id="my_form" for={@form} phx-submit="submit" phx-change="validate">
          <!-- Drawer body -->
          <div class="p-4 md:p-5 space-y-4">
            <.input type="text" field={f[:name]} placeholder="name" />
            <.input type="text" field={f[:type]} placeholder="type" />
          </div>
          <!-- Drawer footer -->
          <div class="flex items-center p-4 md:p-5 border-t border-gray-200 rounded-b dark:border-gray-600">
            <button
              type="submit"
              phx-click={Drawer.hide("drawer_2")}
              class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
            >
              Submit
            </button>
            <button
              type="button"
              phx-click={Drawer.hide("drawer_2")}
              class="py-2.5 px-5 ms-3 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-100 dark:focus:ring-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700"
            >
              Cancel
            </button>
          </div>
        </.form>
      </p>
    </Drawer.base>
    """
  end

  defp drawer_loading_data(assigns) do
    ~H"""
    <Button.base phx-click={Drawer.show("drawer_1")}>Loading data drawer</Button.base>

    <Drawer.base
      id="drawer_1"
      closable?={false}
      mount_showing?={@live_action == :drawer_1}
      on_hide={JS.patch(~p"/drawer") |> JS.push("reset_shit")}
      on_show={JS.patch(~p"/drawer/open_1") |> JS.push("load_shit")}
    >
      <h5
        id="drawer-label-1"
        class="inline-flex items-center mb-4 text-base font-semibold text-gray-500 dark:text-gray-400"
      >
        <svg
          class="w-4 h-4 me-2.5"
          aria-hidden="true"
          xmlns="http://www.w3.org/2000/svg"
          fill="currentColor"
          viewBox="0 0 20 20"
        >
        <path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z" />
      </svg>Info
      </h5>
      <button
        type="button"
        phx-click={Drawer.hide("drawer_1")}
        class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 absolute top-2.5 end-2.5 flex items-center justify-center dark:hover:bg-gray-600 dark:hover:text-white"
      >
        <svg
          class="w-3 h-3"
          aria-hidden="true"
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 14 14"
        >
          <path
            stroke="currentColor"
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"
          />
        </svg>
        <span class="sr-only">Close menu</span>
      </button>

      <p class="mb-6 text-sm text-gray-500 dark:text-gray-400">
        Supercharge your hiring by taking advantage of our
        <a href="#" class="text-blue-600 underline dark:text-blue-500 hover:no-underline">
          limited-time sale
        </a>
        for Flowbite Docs + Job Board. Unlimited access to over 190K top-ranked candidates and the #1 design job board.
      </p>
      <div class="grid grid-cols-2 gap-4">
        <a
          href="#"
          class="px-4 py-2 text-sm font-medium text-center text-gray-900 bg-white border border-gray-200 rounded-lg focus:outline-none hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-100 dark:focus:ring-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700"
        >
          Learn more
        </a>
        <a
          href="#"
          class="inline-flex items-center px-4 py-2 text-sm font-medium text-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800"
        >
          Get access
          <svg
            class="rtl:rotate-180 w-3.5 h-3.5 ms-2"
            aria-hidden="true"
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 14 10"
          >
            <path
              stroke="currentColor"
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M1 5h12m0 0L9 1m4 4L9 9"
            />
          </svg>
        </a>
      </div>

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

        <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
          With less than a month to go before the European Union enacts new consumer privacy laws for its citizens, companies around the world are updating their terms of service agreements to comply.
        </p>
        <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
          The European Union’s General Data Protection Regulation (G.D.P.R.) goes into effect on May 25 and is meant to ensure a common set of data rights in the European Union. It requires organizations to notify users as soon as possible of high-risk data breaches that could personally affect them.
        </p>
      </.async_result>
    </Drawer.base>
    """
  end

  defp load_shit do
    Process.sleep(3_000)

    %{text: "blibs"}
  end
end
