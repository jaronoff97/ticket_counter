defmodule TicketCounter.Repo.Migrations.CreateCounter do
  use Ecto.Migration

  def change do
    create table(:counter) do
      add :count, :integer
      add :color, :string

      timestamps()
    end
  end
end
