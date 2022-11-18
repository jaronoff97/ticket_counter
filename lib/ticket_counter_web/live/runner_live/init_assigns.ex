defmodule TicketCounterWeb.RunnerLive.InitAssigns do
  @moduledoc """
  Ensures common `assigns` are applied to all LiveViews attaching this hook.
  """
  import Phoenix.LiveView
  import Phoenix.Component
  alias TicketCounter.Pixels.Runner

  def on_mount(:default, _params, _session, socket) do
    {:cont, assign(socket, :current_runner, %Runner{})}
  end

end