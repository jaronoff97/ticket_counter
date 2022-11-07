defmodule TicketCounter.TicketsTest do
  use TicketCounter.DataCase

  alias TicketCounter.Tickets

  describe "ticket" do
    alias TicketCounter.Tickets.Ticket

    import TicketCounter.TicketsFixtures

    @invalid_attrs %{name: nil, number: nil}

    test "list_ticket/0 returns all ticket" do
      ticket = ticket_fixture()
      assert Tickets.list_ticket() == [ticket]
    end

    test "get_ticket!/1 returns the ticket with given id" do
      ticket = ticket_fixture()
      assert Tickets.get_ticket!(ticket.id) == ticket
    end

    test "create_ticket/1 with valid data creates a ticket" do
      valid_attrs = %{name: "some name", number: 42}

      assert {:ok, %Ticket{} = ticket} = Tickets.create_ticket(valid_attrs)
      assert ticket.name == "some name"
      assert ticket.number == 42
    end

    test "create_ticket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tickets.create_ticket(@invalid_attrs)
    end

    test "update_ticket/2 with valid data updates the ticket" do
      ticket = ticket_fixture()
      update_attrs = %{name: "some updated name", number: 43}

      assert {:ok, %Ticket{} = ticket} = Tickets.update_ticket(ticket, update_attrs)
      assert ticket.name == "some updated name"
      assert ticket.number == 43
    end

    test "update_ticket/2 with invalid data returns error changeset" do
      ticket = ticket_fixture()
      assert {:error, %Ecto.Changeset{}} = Tickets.update_ticket(ticket, @invalid_attrs)
      assert ticket == Tickets.get_ticket!(ticket.id)
    end

    test "delete_ticket/1 deletes the ticket" do
      ticket = ticket_fixture()
      assert {:ok, %Ticket{}} = Tickets.delete_ticket(ticket)
      assert_raise Ecto.NoResultsError, fn -> Tickets.get_ticket!(ticket.id) end
    end

    test "change_ticket/1 returns a ticket changeset" do
      ticket = ticket_fixture()
      assert %Ecto.Changeset{} = Tickets.change_ticket(ticket)
    end
  end
end
