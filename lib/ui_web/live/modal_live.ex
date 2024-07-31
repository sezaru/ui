defmodule UiWeb.ModalLive do
  @moduledoc false

  alias UI.{Modal, Button}

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

    case AshPhoenix.Form.submit(form, params: params) do
      {:error, form} ->
        {:noreply, assign(socket, form: form)}

      {:ok, resource} ->
        dbg(resource)

        {:noreply, socket}
    end
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
    <.modal_loading_data live_action={@live_action} data={@data} />
    <br />
    <.modal_with_restoring_form live_action={@live_action} form={@form} />
    """
  end

  defp modal_with_restoring_form(assigns) do
    ~H"""
    <Button.base phx-click={Modal.show("modal_2")}>Modal with restoring form</Button.base>

    <Modal.base
      id="modal_2"
      closable?={true}
      mount_showing?={@live_action == :modal_2}
      on_hide={JS.patch(~p"/modal")}
      on_show={JS.patch(~p"/modal/open_2")}
    >
      <!-- Modal header -->
      <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t dark:border-gray-600">
        <h3 class="text-xl font-semibold text-gray-900 dark:text-white">
          Modal with form
        </h3>
        <button
          type="button"
          class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white"
          phx-click={Modal.hide("modal_2")}
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
          <span class="sr-only">Close modal</span>
        </button>
      </div>

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
            phx-click={Modal.hide("modal_2")}
            class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
          >
            Submit
          </button>
          <button
            type="button"
            phx-click={Modal.hide("modal_2")}
            class="py-2.5 px-5 ms-3 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-100 dark:focus:ring-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700"
          >
            Cancel
          </button>
        </div>
      </.form>
    </Modal.base>
    """
  end

  defp modal_loading_data(assigns) do
    ~H"""
    <Button.base phx-click={Modal.show("modal_1")}>Loading data modal</Button.base>

    <Modal.base
      id="modal_1"
      closable?={false}
      mount_showing?={@live_action == :modal_1}
      on_hide={JS.patch(~p"/modal") |> JS.push("reset_shit")}
      on_show={JS.patch(~p"/modal/open_1") |> JS.push("load_shit")}
    >
      <!-- Modal header -->
      <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t dark:border-gray-600">
        <h3 class="text-xl font-semibold text-gray-900 dark:text-white">
          Loading data inside
        </h3>
        <button
          type="button"
          class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white"
          phx-click={Modal.hide("modal_1")}
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
          <span class="sr-only">Close modal</span>
        </button>
      </div>
      <!-- Modal body -->
      <div class="p-4 md:p-5 space-y-4">
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
      </div>
      <!-- Modal footer -->
      <div class="flex items-center p-4 md:p-5 border-t border-gray-200 rounded-b dark:border-gray-600">
        <button
          type="button"
          phx-click={Modal.hide("modal_1")}
          class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
        >
          I accept
        </button>
        <button
          type="button"
          phx-click={Modal.hide("modal_1")}
          class="py-2.5 px-5 ms-3 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-100 dark:focus:ring-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700"
        >
          Decline
        </button>
      </div>
    </Modal.base>
    """
  end

  defp load_shit do
    Process.sleep(3_000)

    %{text: "blibs"}
  end
end
