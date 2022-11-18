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
end
