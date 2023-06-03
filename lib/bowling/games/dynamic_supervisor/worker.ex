defmodule Bowling.Games.DynamicSupervisor.Worker do
  @moduledoc """
  Worker of the supervisor, each worker keep the state of the game alive.
  """

  use GenServer

  def start_link(game) do
    GenServer.start_link(__MODULE__, game, name: ref(game))
  end

  def init(game) do
    {:ok, game}
  end

  defp ref(game),
    do: {:global, {:game, game.id}}
end
