defmodule UI.Modal do
  @moduledoc false

  alias Phoenix.LiveView.JS

  use Phoenix.LiveComponent

  import Turboprop.Variants, only: [variant: 2]

  attr :id, :string, required: true

  attr :closable?, :boolean, default: true
  attr :mount_showing?, :boolean, default: false

  attr :on_show, JS, default: %JS{}
  attr :on_hide, JS, default: %JS{}

  attr :rest, :global

  slot :inner_block, required: true

  def base(assigns) do
    ~H"""
    <div id={@id} {@rest}>
      <div
        modal
        tabindex="-1"
        aria-hidden={if not @mount_showing?, do: "true"}
        aria-modal={if @mount_showing?, do: "true"}
        role={if @mount_showing?, do: "dialog"}
        class={variant(modal(), slot: :outer_modal, showing?: @mount_showing?)}
        data-on-show={@on_show}
        data-on-hide={@on_hide}
        phx-mounted={if @mount_showing?, do: call_on_show(@id)}
      >
        <div
          class={variant(modal(), slot: :modal_margin)}
          phx-click-away={if @closable?, do: hide(@id)}
          phx-window-keyup={if @closable?, do: hide(@id)}
          phx-key={if @closable?, do: "escape"}
        >
          <div class={variant(modal(), slot: :modal_border)}>
            <%= render_slot(@inner_block) %>
          </div>
        </div>
      </div>

      <.backdrop parent_id={@id} closable?={@closable?} mount_showing?={@mount_showing?} />
    </div>
    """
  end

  def call_on_show(%JS{} = js \\ %JS{}, id) do
    modal_path = modal_path(id)

    JS.exec(js, "data-on-show", to: modal_path)
  end

  def show(%JS{} = js \\ %JS{}, id) do
    modal_path = modal_path(id)
    backdrop_path = backdrop_path(id)

    js
    |> JS.add_class("flex", to: modal_path)
    |> JS.remove_class("hidden", to: modal_path)
    |> JS.remove_attribute("aria-hidden", to: modal_path)
    |> JS.set_attribute({"aria-modal", "true"}, to: modal_path)
    |> JS.set_attribute({"role", "dialog"}, to: modal_path)
    |> JS.add_class("block", to: backdrop_path)
    |> JS.remove_class("hidden", to: backdrop_path)
    |> JS.exec("data-on-show", to: modal_path)
  end

  def hide(%JS{} = js \\ %JS{}, id) do
    modal_path = modal_path(id)
    backdrop_path = backdrop_path(id)

    js
    |> JS.add_class("hidden", to: modal_path)
    |> JS.remove_class("flex", to: modal_path)
    |> JS.set_attribute({"aria-hidden", "true"}, to: modal_path)
    |> JS.remove_attribute("aria-modal", to: modal_path)
    |> JS.remove_attribute("role", to: modal_path)
    |> JS.add_class("hidden", to: backdrop_path)
    |> JS.remove_class("block", to: backdrop_path)
    |> JS.exec("data-on-hide", to: modal_path)
  end

  attr :parent_id, :string

  attr :closable?, :boolean, required: true
  attr :mount_showing?, :boolean, default: false

  defp backdrop(assigns) do
    ~H"""
    <div
      backdrop
      class={variant(modal(), slot: :backdrop, showing?: @mount_showing?)}
      phx-click={hide(@parent_id)}
    >
    </div>
    """
  end

  defp modal do
    [
      slots: [
        outer_modal: """
        overflow-y-auto overflow-x-hidden fixed
        top-0 right-0 left-0 z-50 justify-center items-center
        w-full md:inset-0 h-[calc(100%-1rem)] max-h-full
        """,
        modal_margin: "relative p-4 w-full max-w-2xl max-h-full",
        modal_border: "relative bg-white rounded-lg shadow dark:bg-gray-700",
        backdrop: "hidden bg-gray-900/50 dark:bg-gray-900/80 fixed inset-0 z-40"
      ],
      compound_slots: [
        [slots: [:outer_modal], showing?: true, class: "flex"],
        [slots: [:outer_modal], showing?: false, class: "hidden"],
        [slots: [:backdrop], showing?: true, class: "block"],
        [slots: [:backdrop], showing?: false, class: "hidden"]
      ]
    ]
  end

  defp modal_path(id), do: "##{id} > div[modal]"
  defp backdrop_path(id), do: "##{id} > div[backdrop]"
end
