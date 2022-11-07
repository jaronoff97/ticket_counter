defmodule TicketCounter.Tickets.Ticket do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ticket" do
    field :name, :string

    # number is auto incrementing
    field :number, :integer

    timestamps()
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
