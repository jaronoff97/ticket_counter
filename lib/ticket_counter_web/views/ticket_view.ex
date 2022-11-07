defmodule TicketCounterWeb.TicketView do
  use TicketCounterWeb, :view
  alias TicketCounterWeb.TicketView

  def render("index.json", %{ticket: ticket}) do
    %{data: render_many(ticket, TicketView, "ticket.json")}
  end

  def render("show.json", %{ticket: ticket}) do
    %{data: render_one(ticket, TicketView, "ticket.json")}
  end

  def render("ticket.json", %{ticket: ticket}) do
    %{
      id: ticket.id,
      number: ticket.number,
      name: ticket.name
    }
  end
end
