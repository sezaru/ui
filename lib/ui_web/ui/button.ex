defmodule UI.Button do
  @moduledoc false

  use Phoenix.LiveComponent

  import Turboprop.Variants, only: [variant: 2]
  import Turboprop.Merge, only: [merge: 1]

  attr :type, :atom, default: nil
  attr :size, :atom, default: nil

  attr :loading?, :boolean, default: false

  attr :rest, :global

  slot :left_icon
  slot :right_icon

  slot :inner_block

  def base(assigns) do
    ~H"""
    <button class={variant(button(), type: @type, size: @size, loading?: @loading?)} {@rest}>
      <%= if valid_slot?(@left_icon) do %>
        <%= render_slot(@left_icon, class: variant(button(), slot: :left_icon, size: @size)) %>

        <.loading class={variant(button(), slot: :left_loading, size: @size)} />
      <% end %>

      <.loading
        :if={not valid_slot?(@left_icon) and not valid_slot?(@right_icon)}
        class={variant(button(), slot: :left_loading, size: @size)}
      />

      <%= render_slot(@inner_block) %>

      <%= if valid_slot?(@right_icon) do %>
        <%= render_slot(@right_icon, class: variant(button(), slot: :right_icon, size: @size)) %>

        <.loading class={variant(button(), slot: :right_loading, size: @size)} />
      <% end %>
    </button>
    """
  end

  attr :type, :atom, default: nil
  attr :size, :atom, default: nil

  attr :rounded?, :boolean, default: false
  attr :loading?, :boolean, default: false

  attr :rest, :global

  slot :icon, required: true

  def icon(assigns) do
    ~H"""
    <button
      class={
        variant(icon_button(), type: @type, size: @size, rounded?: @rounded?, loading?: @loading?)
      }
      {@rest}
    >
      <%= render_slot(@icon, class: variant(icon_button(), slot: :icon, size: @size)) %>

      <.loading class={variant(icon_button(), slot: :loading, size: @size)} />
    </button>
    """
  end

  attr :class, :string, default: ""

  defp loading(%{class: class} = assigns) do
    assigns = assign(assigns, class: merge(["animate-spin", class]))

    ~H"""
    <svg
      class={@class}
      aria-hidden="true"
      role="status"
      viewBox="0 0 100 101"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
        fill="#E5E7EB"
      />
      <path
        d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
        fill="currentColor"
      />
    </svg>
    """
  end

  defp button do
    [
      slots: [
        base: """
        focus:ring-2 font-medium rounded-lg focus:outline-none text-center
        items-center inline-flex group/button
        """,
        left_icon: """
        text-white me-2 block group-[.phx-submit-loading]/button:hidden
        group-[.phx-click-loading]/button:hidden group-[.lv-loading]/button:hidden
        """,
        right_icon: """
        text-white ms-2 block group-[.phx-submit-loading]/button:hidden
        group-[.phx-click-loading]/button:hidden group-[.lv-loading]/button:hidden
        """,
        left_loading: """
        text-white me-2 hidden group-[.phx-submit-loading]/button:block
        group-[.phx-click-loading]/button:block group-[.lv-loading]/button:block
        """,
        right_loading: """
        text-white ms-2 hidden group-[.phx-submit-loading]/button:block
        group-[.phx-click-loading]/button:block group-[.lv-loading]/button:block
        """
      ],
      variants: [
        type: button_types(),
        loading?: [
          true: "phx-click-loading"
        ]
      ],
      compound_slots: [
        [slots: [:base], size: :xs, class: "px-3 py-2 text-xs"],
        [slots: [:base], size: :sm, class: "px-3 py-2 text-sm"],
        [slots: [:base], size: :base, class: "px-5 py-2.5 text-sm"],
        [slots: [:base], size: :lg, class: "px-5 py-3 text-base"],
        [slots: [:base], size: :xl, class: "px-6 py-3.5 text-base"],
        [
          slots: [:left_icon, :right_icon, :left_loading, :right_loading],
          size: :xs,
          class: "size-3"
        ],
        [
          slots: [:left_icon, :right_icon, :left_loading, :right_loading],
          size: :sm,
          class: "size-3"
        ],
        [
          slots: [:left_icon, :right_icon, :left_loading, :right_loading],
          size: :base,
          class: "size-3.5"
        ],
        [
          slots: [:left_icon, :right_icon, :left_loading, :right_loading],
          size: :lg,
          class: "size-4"
        ],
        [
          slots: [:left_icon, :right_icon, :left_loading, :right_loading],
          size: :xl,
          class: "size-4"
        ]
      ],
      default_variants: [
        type: :info,
        size: :base
      ]
    ]
  end

  defp icon_button do
    [
      slots: [
        base: """
        focus:ring-2 font-medium focus:outline-none text-center
        items-center inline-flex group/button
        """,
        icon: """
        text-white block group-[.phx-submit-loading]/button:hidden
        group-[.phx-click-loading]/button:hidden group-[.lv-loading]/button:hidden
        """,
        loading: """
        text-white hidden group-[.phx-submit-loading]/button:block
        group-[.phx-click-loading]/button:block group-[.lv-loading]/button:block
        """
      ],
      variants: [
        type: button_types(),
        rounded?: [
          true: "rounded-full",
          false: "rounded-lg"
        ],
        loading?: [
          true: "lv-loading"
        ]
      ],
      compound_slots: [
        [slots: [:base], size: :xs, class: "p-2.5"],
        [slots: [:base], size: :sm, class: "p-3"],
        [slots: [:base], size: :base, class: "p-3"],
        [slots: [:base], size: :lg, class: "p-4"],
        [slots: [:base], size: :xl, class: "p-[1.125rem]"],
        [slots: [:icon, :loading], size: :xs, class: "size-3"],
        [slots: [:icon, :loading], size: :sm, class: "size-3"],
        [slots: [:icon, :loading], size: :base, class: "size-3.5"],
        [slots: [:icon, :loading], size: :lg, class: "size-4"],
        [slots: [:icon, :loading], size: :xl, class: "size-4"]
      ],
      default_variants: [
        type: :info,
        size: :base
      ]
    ]
  end

  defp button_types do
    [
      # primary: "",
      # secondary: "",
      # white: "",
      info:
        "text-white bg-blue-700 hover:bg-blue-800 focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800",
      success:
        "text-white bg-green-700 hover:bg-green-800 focus:ring-green-300 dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-green-800",
      warning:
        "text-white bg-yellow-400 hover:bg-yellow-500 focus:ring-yellow-300 dark:focus:ring-yellow-900",
      danger:
        "text-white bg-red-700 hover:bg-red-800 focus:ring-red-300 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-900"
    ]
  end

  defp valid_slot?(slot), do: not Enum.empty?(slot)
end
