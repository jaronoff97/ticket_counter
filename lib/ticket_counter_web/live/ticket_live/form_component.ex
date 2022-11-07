defmodule TicketCounterWeb.TicketLive.FormComponent do
  use TicketCounterWeb, :live_component

  alias TicketCounter.Tickets

  @impl true
  def handle_event("validate", %{"ticket" => ticket_params}, socket) do
    changeset =
      socket.assigns.ticket
      |> Tickets.change_ticket(ticket_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"ticket" => ticket_params}, socket) do
    save_ticket(socket, socket.assigns.action, ticket_params)
  end

  defp save_ticket(socket, :new, ticket_params) do
    case Tickets.create_ticket(ticket_params) do
      {:ok, ticket} ->
        {:noreply,
         socket
         |> put_flash(:info, "Ticket created successfully")
         |> assign(:ticket, ticket)
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
