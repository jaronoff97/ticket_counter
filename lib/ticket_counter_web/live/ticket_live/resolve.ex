defmodule TicketCounterWeb.TicketLive.Resolve do
  use TicketCounterWeb, :live_view

  alias TicketCounter.Tickets

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Tickets.subscribe()
    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _session, socket) do
    {:noreply, socket
      |> assign(:ticket, Tickets.get_latest_ticket())}
  end

  @impl true
  def handle_info({:ticket_created, _ticket}, socket) do
    {:noreply, socket
      |> assign(:ticket, Tickets.get_latest_ticket())}
  end

  @impl true
  def handle_info({:ticket_deleted, _ticket}, socket) do
    {:noreply, socket
      |> assign(:ticket, Tickets.get_latest_ticket())}
  end

  @impl true
  def handle_event("resolve_ticket", _value, socket) do
    case Tickets.delete_ticket(socket.assigns.ticket) do
      {:ok, _params} ->
        IO.puts "deleted somethin"
        {:noreply,
         socket
         |> put_flash(:info, "Ticket deleted successfully")
         |> assign(:ticket, Tickets.get_latest_ticket())}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
    {:noreply, socket}
  end
end
