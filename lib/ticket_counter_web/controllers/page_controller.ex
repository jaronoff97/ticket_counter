defmodule TicketCounterWeb.PageController do
  use TicketCounterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
