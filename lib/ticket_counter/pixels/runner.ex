defmodule TicketCounter.Pixels.Runner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "runner" do
    field :color, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(runner, attrs) do
    runner
    |> cast(attrs, [:name, :color])
    |> validate_required([:name, :color])
  end
end
