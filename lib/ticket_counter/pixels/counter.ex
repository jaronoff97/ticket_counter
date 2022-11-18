defmodule TicketCounter.Pixels.Counter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "counter" do
    field :color, :string
    field :count, :integer

    timestamps()
  end

  @doc false
  def changeset(counter, attrs) do
    counter
    |> cast(attrs, [:count, :color])
    |> validate_required([:count, :color])
  end
end
