defmodule TicketCounter.PixelsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TicketCounter.Pixels` context.
  """

  @doc """
  Generate a runner.
  """
  def runner_fixture(attrs \\ %{}) do
    {:ok, runner} =
      attrs
      |> Enum.into(%{
        color: "some color",
        name: "some name"
      })
      |> TicketCounter.Pixels.create_runner()

    runner
  end

  @doc """
  Generate a counter.
  """
  def counter_fixture(attrs \\ %{}) do
    {:ok, counter} =
      attrs
      |> Enum.into(%{
        color: "some color",
        count: 42
      })
      |> TicketCounter.Pixels.create_counter()

    counter
  end
end
