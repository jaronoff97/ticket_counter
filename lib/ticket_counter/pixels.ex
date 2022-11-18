defmodule TicketCounter.Pixels do
  @moduledoc """
  The Pixels context.
  """

  import Ecto.Query, warn: false
  alias TicketCounter.Repo

  alias TicketCounter.Pixels.Runner

  def pixels_left do
    TicketCounter.TidByt.total_dimensions
  end

  def add_pixel(_runner) do
    0
  end

  @doc """
  Returns the list of runner.

  ## Examples

      iex> list_runner()
      [%Runner{}, ...]

  """
  def list_runner do
    Repo.all(Runner)
  end

  @doc """
  Gets a single runner.

  Raises `Ecto.NoResultsError` if the Runner does not exist.

  ## Examples

      iex> get_runner!(123)
      %Runner{}

      iex> get_runner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_runner!(id), do: Repo.get!(Runner, id)

  @doc """
  Creates a runner.

  ## Examples

      iex> create_runner(%{field: value})
      {:ok, %Runner{}}

      iex> create_runner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_runner(attrs \\ %{}) do
    %Runner{}
    |> Runner.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:runner_created)
  end

  @doc """
  Updates a runner.

  ## Examples

      iex> update_runner(runner, %{field: new_value})
      {:ok, %Runner{}}

      iex> update_runner(runner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_runner(%Runner{} = runner, attrs) do
    runner
    |> Runner.changeset(attrs)
    |> Repo.update()
    |> broadcast(:runner_updated)
  end

  @doc """
  Deletes a runner.

  ## Examples

      iex> delete_runner(runner)
      {:ok, %Runner{}}

      iex> delete_runner(runner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_runner(%Runner{} = runner) do
    Repo.delete(runner)
    |> broadcast(:runner_deleted)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking runner changes.

  ## Examples

      iex> change_runner(runner)
      %Ecto.Changeset{data: %Runner{}}

  """
  def change_runner(%Runner{} = runner, attrs \\ %{}) do
    Runner.changeset(runner, attrs)
  end


  def subscribe do
    Phoenix.PubSub.subscribe(TicketCounter.PubSub, "pixels")
  end

  defp broadcast({:error, _reason} = error, _event), do: error
  defp broadcast({:ok, ticket}, event) do
    Phoenix.PubSub.broadcast(TicketCounter.PubSub, "pixels", {event, ticket})
    {:ok, ticket}
  end

end
