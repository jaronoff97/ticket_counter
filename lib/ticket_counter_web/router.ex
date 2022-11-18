defmodule TicketCounterWeb.Router do
  use TicketCounterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TicketCounterWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TicketCounterWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/ticket", TicketLive.Index, :index
    live "/ticket/new", TicketLive.Index, :new
    live "/ticket/resolve", TicketLive.Resolve, :index


  end


  live_session :default, on_mount: TicketCounterWeb.RunnerLive.InitAssigns do
    scope "/", TicketCounterWeb do
      pipe_through :browser
      live "/runner", RunnerLive.Index, :index
      live "/runner/new", RunnerLive.Index, :new
      live "/runner/reset", RunnerLive.Index, :reset
      live "/runner/:id/edit", RunnerLive.Index, :edit
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", TicketCounterWeb do
    pipe_through :api

    get "/tickets", TicketController, :index
    get "/current_ticket", TicketController, :latest
    get "/pixels_left", CounterController, :pixels_left
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TicketCounterWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
