defmodule Bowling.Games.DynamicSupervisor.Worker do
  @moduledoc """
  Worker of the supervisor, each worker keep the state of the game alive.
  """

  use GenServer

  # Client

  def start_link(game) do
    GenServer.start_link(__MODULE__, game, name: ref(game.id))
  end

  def fetch_by_id(id) do
    case GenServer.whereis(ref(id)) do
      nil -> :not_found
      _ -> GenServer.call(ref(id), :fetch_by_id)
    end
  end

  def update(game) do
    case GenServer.whereis(ref(game.id)) do
      nil -> :not_found
      _ -> GenServer.call(ref(game.id), {:update, game})
    end
  end

  # Server (callbacks)

  @impl true
  def init(game) do
    {:ok, game}
  end

  @impl true
  def handle_call(:fetch_by_id, _from, game) do
    {:reply, {:ok, game}, game}
  end

  @impl true
  def handle_call({:update, game}, _from, _state) do
    {:reply, {:ok, game}, game}
  end

  defp ref(id), do: {:global, {:game, id}}
end
