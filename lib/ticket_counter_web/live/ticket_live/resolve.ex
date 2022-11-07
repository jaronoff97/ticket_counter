defmodule TicketCounterWeb.TicketLive.Resolve do
  use TicketCounterWeb, :live_view

  alias TicketCounter.Tickets

  @impl true
  def mount(_params, _session, socket) do

    {:ok, socket}
  end

  @impl true
  def handle_params(params, session, socket) do
    IO.puts "----------------"
    IO.puts inspect(params)
    IO.puts inspect(session)
    IO.puts "----------------"
    {:noreply, socket
      |> assign(:ticket, Tickets.get_latest_ticket())}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:ticket, Tickets.get_ticket!(id))}
  end

  defp page_title(:show), do: "Show Ticket"
  defp page_title(:edit), do: "Edit Ticket"

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
