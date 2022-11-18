defmodule TicketCounterWeb.CounterView do
  use TicketCounterWeb, :view
  alias TicketCounterWeb.CounterView

  def render("index.json", %{counter: counter}) do
    %{data: render_many(counter, CounterView, "counter.json")}
  end

  def render("show.json", %{counter: counter}) do
    %{data: render_one(counter, CounterView, "counter.json")}
  end

  def render("counter.json", %{counter: counter}) do
    %{
      id: counter.id,
      count: counter.count,
      color: counter.color
    }
  end
end
