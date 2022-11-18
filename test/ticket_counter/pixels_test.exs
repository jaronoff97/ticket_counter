defmodule TicketCounter.PixelsTest do
  use TicketCounter.DataCase

  alias TicketCounter.Pixels

  describe "runner" do
    alias TicketCounter.Pixels.Runner

    import TicketCounter.PixelsFixtures

    @invalid_attrs %{color: nil, name: nil}

    test "list_runner/0 returns all runner" do
      runner = runner_fixture()
      assert Pixels.list_runner() == [runner]
    end

    test "get_runner!/1 returns the runner with given id" do
      runner = runner_fixture()
      assert Pixels.get_runner!(runner.id) == runner
    end

    test "create_runner/1 with valid data creates a runner" do
      valid_attrs = %{color: "some color", name: "some name"}

      assert {:ok, %Runner{} = runner} = Pixels.create_runner(valid_attrs)
      assert runner.color == "some color"
      assert runner.name == "some name"
    end

    test "create_runner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pixels.create_runner(@invalid_attrs)
    end

    test "update_runner/2 with valid data updates the runner" do
      runner = runner_fixture()
      update_attrs = %{color: "some updated color", name: "some updated name"}

      assert {:ok, %Runner{} = runner} = Pixels.update_runner(runner, update_attrs)
      assert runner.color == "some updated color"
      assert runner.name == "some updated name"
    end

    test "update_runner/2 with invalid data returns error changeset" do
      runner = runner_fixture()
      assert {:error, %Ecto.Changeset{}} = Pixels.update_runner(runner, @invalid_attrs)
      assert runner == Pixels.get_runner!(runner.id)
    end

    test "delete_runner/1 deletes the runner" do
      runner = runner_fixture()
      assert {:ok, %Runner{}} = Pixels.delete_runner(runner)
      assert_raise Ecto.NoResultsError, fn -> Pixels.get_runner!(runner.id) end
    end

    test "change_runner/1 returns a runner changeset" do
      runner = runner_fixture()
      assert %Ecto.Changeset{} = Pixels.change_runner(runner)
    end
  end
end
