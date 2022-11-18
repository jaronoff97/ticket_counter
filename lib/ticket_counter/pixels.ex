defmodule TicketCounter.Pixels do
  @moduledoc """
  The Pixels context.
  """

  import Ecto.Query, warn: false
  alias TicketCounter.Repo

  alias TicketCounter.Pixels.Runner
  alias TicketCounter.Pixels.Counter

  def get_counter do
     Counter
      |> first(:id)
      |> Repo.one
  end

  def pixels_left do
    {get_counter(), TicketCounter.TidByt.total_dimensions}
  end

  def reset_pixels do
    get_counter()
    |> reset_counter
    |> broadcast(:counter_changed)
    |> TicketCounter.TidByt.update_tidbyt(:pixels)
  end

  def add_pixel(runner) do
    get_counter()
    |> create_or_update_counter(runner)
    |> broadcast(:counter_changed)
    |> TicketCounter.TidByt.update_tidbyt(:pixels)
  end

  def reset_counter(c) do
    update_counter(c, %{color: "#000000", count: 0})
  end

  def create_or_update_counter(nil, runner) do
    create_counter(%{color: runner.color, count: 1})
  end

  def create_or_update_counter(c, runner) do
    if c.count >= TicketCounter.TidByt.total_dimensions do
      update_counter(c, %{color: c.color, count: c.count})
    else
      update_counter(c, %{color: runner.color, count: c.count + 1})
    end
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

  @doc """
  Returns the list of counter.

  ## Examples

      iex> list_counter()
      [%Counter{}, ...]

  """
  def list_counter do
    Repo.all(Counter)
  end

  @doc """
  Gets a single counter.

  Raises `Ecto.NoResultsError` if the Counter does not exist.

  ## Examples

      iex> get_counter!(123)
      %Counter{}

      iex> get_counter!(456)
      ** (Ecto.NoResultsError)

  """
  def get_counter!(id), do: Repo.get!(Counter, id)

  @doc """
  Creates a counter.

  ## Examples

      iex> create_counter(%{field: value})
      {:ok, %Counter{}}

      iex> create_counter(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_counter(attrs \\ %{}) do
    %Counter{}
    |> Counter.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a counter.

  ## Examples

      iex> update_counter(counter, %{field: new_value})
      {:ok, %Counter{}}

      iex> update_counter(counter, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_counter(%Counter{} = counter, attrs) do
    counter
    |> Counter.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a counter.

  ## Examples

      iex> delete_counter(counter)
      {:ok, %Counter{}}

      iex> delete_counter(counter)
      {:error, %Ecto.Changeset{}}

  """
  def delete_counter(%Counter{} = counter) do
    Repo.delete(counter)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking counter changes.

  ## Examples

      iex> change_counter(counter)
      %Ecto.Changeset{data: %Counter{}}

  """
  def change_counter(%Counter{} = counter, attrs \\ %{}) do
    Counter.changeset(counter, attrs)
  end
end
