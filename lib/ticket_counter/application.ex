defmodule TicketCounter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TicketCounter.Repo,
      # Start the Telemetry supervisor
      TicketCounterWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TicketCounter.PubSub},
      # Start the Endpoint (http/https)
      TicketCounterWeb.Endpoint
      # Start a worker by calling: TicketCounter.Worker.start_link(arg)
      # {TicketCounter.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TicketCounter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TicketCounterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
