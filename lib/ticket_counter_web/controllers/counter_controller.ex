defmodule TicketCounterWeb.CounterController do
  use TicketCounterWeb, :controller

  alias TicketCounter.Pixels

  action_fallback TicketCounterWeb.FallbackController

  def pixels_left(conn, _params) do
    counter = Pixels.get_counter
    render(conn, "show.json", counter: counter)
  end
end
