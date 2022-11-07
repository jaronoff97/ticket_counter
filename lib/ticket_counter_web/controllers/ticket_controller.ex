defmodule TicketCounterWeb.TicketController do
  use TicketCounterWeb, :controller

  alias TicketCounter.Tickets
  alias TicketCounter.Tickets.Ticket

  action_fallback TicketCounterWeb.FallbackController

  def index(conn, _params) do
    ticket = Tickets.list_ticket()
    render(conn, "index.json", ticket: ticket)
  end

  def show(conn, %{"id" => id}) do
    ticket = Tickets.get_ticket!(id)
    render(conn, "show.json", ticket: ticket)
  end

  def latest(conn, _params) do
    ticket = Tickets.get_latest_ticket()
    render(conn, "show.json", ticket: ticket)
  end

  def update(conn, %{"id" => id, "ticket" => ticket_params}) do
    ticket = Tickets.get_ticket!(id)

    with {:ok, %Ticket{} = ticket} <- Tickets.update_ticket(ticket, ticket_params) do
      render(conn, "show.json", ticket: ticket)
    end
  end

  def delete(conn, %{"id" => id}) do
    ticket = Tickets.get_ticket!(id)

    with {:ok, %Ticket{}} <- Tickets.delete_ticket(ticket) do
      send_resp(conn, :no_content, "")
    end
  end
end
