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

  describe "counter" do
    alias TicketCounter.Pixels.Counter

    import TicketCounter.PixelsFixtures

    @invalid_attrs %{color: nil, count: nil}

    test "list_counter/0 returns all counter" do
      counter = counter_fixture()
      assert Pixels.list_counter() == [counter]
    end

    test "get_counter!/1 returns the counter with given id" do
      counter = counter_fixture()
      assert Pixels.get_counter!(counter.id) == counter
    end

    test "create_counter/1 with valid data creates a counter" do
      valid_attrs = %{color: "some color", count: 42}

      assert {:ok, %Counter{} = counter} = Pixels.create_counter(valid_attrs)
      assert counter.color == "some color"
      assert counter.count == 42
    end

    test "create_counter/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pixels.create_counter(@invalid_attrs)
    end

    test "update_counter/2 with valid data updates the counter" do
      counter = counter_fixture()
      update_attrs = %{color: "some updated color", count: 43}

      assert {:ok, %Counter{} = counter} = Pixels.update_counter(counter, update_attrs)
      assert counter.color == "some updated color"
      assert counter.count == 43
    end

    test "update_counter/2 with invalid data returns error changeset" do
      counter = counter_fixture()
      assert {:error, %Ecto.Changeset{}} = Pixels.update_counter(counter, @invalid_attrs)
      assert counter == Pixels.get_counter!(counter.id)
    end

    test "delete_counter/1 deletes the counter" do
      counter = counter_fixture()
      assert {:ok, %Counter{}} = Pixels.delete_counter(counter)
      assert_raise Ecto.NoResultsError, fn -> Pixels.get_counter!(counter.id) end
    end

    test "change_counter/1 returns a counter changeset" do
      counter = counter_fixture()
      assert %Ecto.Changeset{} = Pixels.change_counter(counter)
    end
  end
end
