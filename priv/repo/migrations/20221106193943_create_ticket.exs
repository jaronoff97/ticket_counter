defmodule TicketCounter.Repo.Migrations.CreateTicket do
  use Ecto.Migration

  def change do
    create table(:ticket) do
      add :number, :serial
      add :name, :string

      timestamps()
    end
  end
end
