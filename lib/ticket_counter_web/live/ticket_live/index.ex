defmodule TicketCounterWeb.TicketLive.Index do
  use TicketCounterWeb, :live_view

  alias TicketCounter.Tickets
  alias TicketCounter.Tickets.Ticket

  @impl true
  def mount(_params, _session, socket) do
    {:ok, 
      assign(socket, :ticket_collection, list_ticket())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Ticket")
    |> assign(:ticket, Tickets.get_ticket!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Ticket")
    |> assign(:ticket, %Ticket{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Ticket")
    |> assign(:ticket, %Ticket{})
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    ticket = Tickets.get_ticket!(id)
    {:ok, _} = Tickets.delete_ticket(ticket)

    {:noreply, assign(socket, :ticket_collection, list_ticket())}
  end

  defp list_ticket do
    Tickets.list_ticket()
  end
end
