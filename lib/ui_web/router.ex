defmodule UiWeb.Router do
  use UiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {UiWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", UiWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/button", ButtonLive

    live "/modal", ModalLive, :index
    live "/modal/open_1", ModalLive, :modal_1
    live "/modal/open_2", ModalLive, :modal_2

    live "/drawer", DrawerLive, :index
    live "/drawer/open_1", DrawerLive, :drawer_1
    live "/drawer/open_2", DrawerLive, :drawer_2

    live "/tabs", TabsLive, :index
    live "/tabs/load_shit", TabsLive, :load_shit
    live "/tabs/with_form", TabsLive, :with_form
  end
end
