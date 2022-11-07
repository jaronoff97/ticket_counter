defmodule TicketCounter.Repo do
  use Ecto.Repo,
    otp_app: :ticket_counter,
    adapter: Ecto.Adapters.Postgres
end
