defmodule UI.Drawer do
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
        drawer
        tabindex="-1"
        aria-hidden={if not @mount_showing?, do: "true"}
        aria-modal={if @mount_showing?, do: "true"}
        role={if @mount_showing?, do: "dialog"}
        class={variant(drawer(), slot: :drawer, showing?: @mount_showing?)}
        data-on-show={@on_show}
        data-on-hide={@on_hide}
        phx-mounted={if @mount_showing?, do: call_on_show(@id)}
        phx-click-away={if @closable?, do: hide(@id)}
        phx-window-keyup={if @closable?, do: hide(@id)}
        phx-key={if @closable?, do: "escape"}
      >
        <%= render_slot(@inner_block) %>
      </div>

      <.backdrop parent_id={@id} closable?={@closable?} mount_showing?={@mount_showing?} />
    </div>
    """
  end

  def call_on_show(%JS{} = js \\ %JS{}, id) do
    drawer_path = drawer_path(id)

    JS.exec(js, "data-on-show", to: drawer_path)
  end

  def show(%JS{} = js \\ %JS{}, id) do
    drawer_path = drawer_path(id)
    backdrop_path = backdrop_path(id)

    js
    |> JS.add_class("transform-none", to: drawer_path)
    |> JS.remove_class("-translate-x-full", to: drawer_path)
    |> JS.remove_attribute("aria-hidden", to: drawer_path)
    |> JS.set_attribute({"aria-modal", "true"}, to: drawer_path)
    |> JS.set_attribute({"role", "dialog"}, to: drawer_path)
    |> JS.add_class("block", to: backdrop_path)
    |> JS.remove_class("hidden", to: backdrop_path)
    |> JS.exec("data-on-show", to: drawer_path)
  end

  def hide(%JS{} = js \\ %JS{}, id) do
    drawer_path = drawer_path(id)
    backdrop_path = backdrop_path(id)

    js
    |> JS.add_class("-translate-x-full", to: drawer_path)
    |> JS.remove_class("transform-none", to: drawer_path)
    |> JS.set_attribute({"aria-hidden", "true"}, to: drawer_path)
    |> JS.remove_attribute("aria-modal", to: drawer_path)
    |> JS.remove_attribute("role", to: drawer_path)
    |> JS.add_class("hidden", to: backdrop_path)
    |> JS.remove_class("block", to: backdrop_path)
    |> JS.exec("data-on-hide", to: drawer_path)
  end

  attr :parent_id, :string

  attr :closable?, :boolean, required: true
  attr :mount_showing?, :boolean, default: false

  defp backdrop(assigns) do
    ~H"""
    <div
      backdrop
      class={variant(drawer(), slot: :backdrop, showing?: @mount_showing?)}
      phx-click={hide(@parent_id)}
    >
    </div>
    """
  end

  defp drawer do
    [
      slots: [
        drawer: """
        fixed top-0 left-0 z-40 h-screen p-4 overflow-y-auto transition-transform bg-white
        w-80 dark:bg-gray-800
        """,
        backdrop: "hidden bg-gray-900/50 dark:bg-gray-900/80 fixed inset-0 z-30"
      ],
      compound_slots: [
        [slots: [:drawer], showing?: true, class: "translate-none"],
        [slots: [:drawer], showing?: false, class: "-translate-x-full"],
        [slots: [:backdrop], showing?: true, class: "block"],
        [slots: [:backdrop], showing?: false, class: "hidden"]
      ]
    ]
  end

  defp drawer_path(id), do: "##{id} > div[drawer]"
  defp backdrop_path(id), do: "##{id} > div[backdrop]"
end
