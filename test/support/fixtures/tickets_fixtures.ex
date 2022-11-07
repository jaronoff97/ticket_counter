defmodule TicketCounter.TicketsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TicketCounter.Tickets` context.
  """

  @doc """
  Generate a ticket.
  """
  def ticket_fixture(attrs \\ %{}) do
    {:ok, ticket} =
      attrs
      |> Enum.into(%{
        name: "some name",
        number: 42
      })
      |> TicketCounter.Tickets.create_ticket()

    ticket
  end
end
