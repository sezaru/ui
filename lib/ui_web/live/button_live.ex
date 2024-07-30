defmodule UiWeb.ButtonLive do
  @moduledoc false

  alias UI.Button

  use UiWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, loading?: false)}
  end

  def handle_event("blibs", _, socket) do
    Process.sleep(5_000)
    IO.puts("done")
    {:noreply, assign(socket, loading?: true)}
  end

  def handle_event("blibs1", _, socket) do
    Process.sleep(2_000)
    IO.puts("done")
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col gap-2">
      <div class="flex items-center gap-2">
        <Button.base type={:info} size={:xs}>A xs button</Button.base>
        <Button.base type={:info} size={:sm}>A small button</Button.base>
        <Button.base type={:info}>A normal button</Button.base>
        <Button.base type={:info} size={:lg}>A large button</Button.base>
        <Button.base type={:info} size={:xl}>A xl button</Button.base>
      </div>

      <div class="flex items-center gap-2">
        <Button.base type={:success} size={:xs}>A xs button</Button.base>
        <Button.base type={:success} size={:sm}>A small button</Button.base>
        <Button.base type={:success}>A normal button</Button.base>
        <Button.base type={:success} size={:lg}>A large button</Button.base>
        <Button.base type={:success} size={:xl}>A xl button</Button.base>
      </div>

      <div class="flex items-center gap-2">
        <Button.base type={:warning} size={:xs}>A xs button</Button.base>
        <Button.base type={:warning} size={:sm}>A small button</Button.base>
        <Button.base type={:warning}>A normal button</Button.base>
        <Button.base type={:warning} size={:lg}>A large button</Button.base>
        <Button.base type={:warning} size={:xl}>A xl button</Button.base>
      </div>

      <div class="flex items-center gap-2">
        <Button.base type={:danger} size={:xs}>A xs button</Button.base>
        <Button.base type={:danger} size={:sm}>A small button</Button.base>
        <Button.base type={:danger}>A normal button</Button.base>
        <Button.base type={:danger} size={:lg}>A large button</Button.base>
        <Button.base type={:danger} size={:xl}>A xl button</Button.base>
      </div>

      <div class="flex items-center gap-2">
        <Button.base type={:info} size={:xs} phx-click="blibs1">Buy now</Button.base>
        <Button.base type={:info} size={:sm} phx-click="blibs1">Buy now</Button.base>
        <Button.base type={:info} phx-click="blibs1">Buy now</Button.base>
        <Button.base type={:info} size={:lg} phx-click="blibs1">Buy now</Button.base>
        <Button.base type={:info} size={:xl} phx-click="blibs1">Buy now</Button.base>
      </div>

      <div class="flex items-center gap-2">
        <Button.base type={:info} size={:xs} phx-click="blibs1">
          <:left_icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:left_icon>
          Buy now
        </Button.base>

        <Button.base type={:info} size={:sm} phx-click="blibs1">
          <:left_icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:left_icon>
          Buy now
        </Button.base>

        <Button.base type={:info} phx-click="blibs1">
          <:left_icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:left_icon>
          Buy now
        </Button.base>

        <Button.base type={:info} size={:lg} phx-click="blibs1">
          <:left_icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:left_icon>
          Buy now
        </Button.base>

        <Button.base type={:info} size={:xl} phx-click="blibs1">
          <:left_icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:left_icon>
          Buy now
        </Button.base>
      </div>

      <div class="flex items-center gap-2">
        <Button.base type={:success} size={:xs} phx-click="blibs1">
          <:right_icon :let={[class: class]}>
            <svg
              class={class}
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
          </:right_icon>
          Next
        </Button.base>

        <Button.base type={:success} size={:sm} phx-click="blibs1">
          <:right_icon :let={[class: class]}>
            <svg
              class={class}
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
          </:right_icon>
          Next
        </Button.base>

        <Button.base type={:success} phx-click="blibs1">
          <:right_icon :let={[class: class]}>
            <svg
              class={class}
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
          </:right_icon>
          Next
        </Button.base>

        <Button.base type={:success} size={:lg} phx-click="blibs1">
          <:right_icon :let={[class: class]}>
            <svg
              class={class}
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
          </:right_icon>
          Next
        </Button.base>

        <Button.base type={:success} size={:xl} phx-click="blibs1">
          <:right_icon :let={[class: class]}>
            <svg
              class={class}
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
          </:right_icon>
          Next
        </Button.base>
      </div>

      <div class="flex items-center gap-2">
        <Button.base type={:danger} size={:xs} phx-click="blibs1">
          <:left_icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:left_icon>

          <:right_icon :let={[class: class]}>
            <svg
              class={class}
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
          </:right_icon>
          Hue
        </Button.base>

        <Button.base type={:danger} size={:sm} phx-click="blibs1">
          <:left_icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:left_icon>

          <:right_icon :let={[class: class]}>
            <svg
              class={class}
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
          </:right_icon>
          Hue
        </Button.base>

        <Button.base type={:danger} phx-click="blibs1">
          <:left_icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:left_icon>

          <:right_icon :let={[class: class]}>
            <svg
              class={class}
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
          </:right_icon>
          Hue
        </Button.base>

        <Button.base type={:danger} size={:lg} phx-click="blibs1">
          <:left_icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:left_icon>

          <:right_icon :let={[class: class]}>
            <svg
              class={class}
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
          </:right_icon>
          Hue
        </Button.base>

        <Button.base type={:danger} size={:xl} phx-click="blibs1">
          <:left_icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:left_icon>

          <:right_icon :let={[class: class]}>
            <svg
              class={class}
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
          </:right_icon>
          Hue
        </Button.base>
      </div>

      <div class="flex items-center gap-2">
        <Button.icon type={:info} size={:xs} rounded?={true} phx-click="blibs1">
          <:icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:icon>
        </Button.icon>

        <Button.icon type={:info} size={:sm} rounded?={true} phx-click="blibs1">
          <:icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:icon>
        </Button.icon>

        <Button.icon type={:info} rounded?={true} phx-click="blibs1">
          <:icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:icon>
        </Button.icon>

        <Button.icon type={:info} size={:lg} rounded?={true} phx-click="blibs1">
          <:icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:icon>
        </Button.icon>

        <Button.icon type={:info} size={:xl} rounded?={true} phx-click="blibs1">
          <:icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:icon>
        </Button.icon>
      </div>

      <div class="flex items-center gap-2">
        <Button.icon type={:danger} size={:xs} phx-click="blibs1">
          <:icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:icon>
        </Button.icon>

        <Button.icon type={:danger} size={:sm} phx-click="blibs1">
          <:icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:icon>
        </Button.icon>

        <Button.icon type={:danger} phx-click="blibs1">
          <:icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:icon>
        </Button.icon>

        <Button.icon type={:danger} size={:lg} phx-click="blibs1">
          <:icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:icon>
        </Button.icon>

        <Button.icon type={:danger} size={:xl} phx-click="blibs1">
          <:icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:icon>
        </Button.icon>
      </div>

      <div class="flex items-center gap-2">
        <Button.icon
          type={:danger}
          size={:xs}
          loading?={@loading?}
          phx-click={if not @loading?, do: "blibs"}
        >
          <:icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:icon>
        </Button.icon>

        <Button.base
          type={:info}
          size={:xs}
          loading?={@loading?}
          phx-click={if not @loading?, do: "blibs"}
        >
          <:left_icon :let={[class: class]}>
            <svg
              class={class}
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 21"
            >
              <path d="M15 12a1 1 0 0 0 .962-.726l2-7A1 1 0 0 0 17 3H3.77L3.175.745A1 1 0 0 0 2.208 0H1a1 1 0 0 0 0 2h.438l.6 2.255v.019l2 7 .746 2.986A3 3 0 1 0 9 17a2.966 2.966 0 0 0-.184-1h2.368c-.118.32-.18.659-.184 1a3 3 0 1 0 3-3H6.78l-.5-2H15Z" />
            </svg>
          </:left_icon>
          Buy now
        </Button.base>
      </div>
    </div>
    """
  end
end
