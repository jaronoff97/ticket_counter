defmodule TicketCounterWeb.RunnerLive.FormComponent do
  use TicketCounterWeb, :live_component

  alias TicketCounter.Pixels

  @impl true
  def update(%{runner: runner} = assigns, socket) do
    changeset = Pixels.change_runner(runner)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"runner" => runner_params}, socket) do
    changeset =
      socket.assigns.runner
      |> Pixels.change_runner(runner_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"runner" => runner_params}, socket) do
    save_runner(socket, socket.assigns.action, runner_params)
  end

  defp save_runner(socket, :edit, runner_params) do
    case Pixels.update_runner(socket.assigns.runner, runner_params) do
      {:ok, runner} ->
        send(self(), {:created_runner, runner})
        {:noreply,
         socket
         |> put_flash(:info, "Runner updated successfully")
         |> assign(:current_runner, runner)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_runner(socket, :new, runner_params) do
    case Pixels.create_runner(runner_params) do
      {:ok, runner} ->
        send(self(), {:set_runner, runner})
        {:noreply,
         socket
         |> put_flash(:info, "Runner created successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
