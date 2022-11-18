defmodule TicketCounter.Repo.Migrations.CreateRunner do
  use Ecto.Migration

  def change do
    create table(:runner) do
      add :name, :string
      add :color, :string

      timestamps()
    end
  end
end
