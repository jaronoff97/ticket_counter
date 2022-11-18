defmodule TicketCounterWeb.RunnerLive.Index do
  use TicketCounterWeb, :live_view

  alias TicketCounter.Pixels
  alias TicketCounter.Pixels.Runner

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Pixels.subscribe()
    {:ok, socket
      |> assign(:runner_collection, list_runner())
      |> assign(:pixels_left, Pixels.pixels_left())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Runner")
    |> assign(:runner, Pixels.get_runner!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Runner")
    |> assign(:runner, %Runner{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Runner")
    |> assign(:runner, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    runner = Pixels.get_runner!(id)
    {:ok, _} = Pixels.delete_runner(runner)

    {:noreply, assign(socket, :runner_collection, list_runner())}
  end

  @impl true
  def handle_event("sign_in", %{"id" => id}, socket) do
    runner = Pixels.get_runner!(id)
    {:noreply, assign(socket, :current_runner, runner)}
  end

  @impl true
  def handle_event("add_pixel", _params, socket) do
    pixels_left = Pixels.add_pixel(socket.assigns.current_runner)
    {:noreply, assign(socket, :pixels_left, pixels_left)}
  end

  @impl true
  def handle_info({:set_runner, runner}, socket) do
    IO.puts "received runner"
    {:noreply, socket
      |> assign(:current_runner, runner)
      |> assign(:runner_collection, list_runner())
      |> put_flash(:info, "Runner made successfully")}
  end

  @impl true
  def handle_info({:runner_updated, runner}, socket) do
    new_runner = Pixels.get_runner!(runner.id)
    {:noreply, assign(socket, :runner_collection, fn runner_collection -> runner_collection ++ [new_runner] end)}
  end

  @impl true
  def handle_info({:runner_created, _runner}, socket) do
    {:noreply, assign(socket, :runner_collection, list_runner())}
  end

  @impl true
  def handle_info({:runner_deleted, runner}, socket) do
    {:noreply, assign(socket, :runner_collection, fn collection -> Enum.filter(collection, fn
        %Runner{id: i} when i == runner.id -> false
        _ -> true
      end)
    end )}
  end

  defp list_runner do
    Pixels.list_runner()
  end
end
