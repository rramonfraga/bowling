defmodule Bowling.Games do
  @moduledoc """
  Business API for create, update and read games
  """
  alias Bowling.Games.DynamicSupervisor, as: GameSupervisor
  alias Bowling.Games.Models.Game

  @spec start(Game.t()) :: {:ok, Game.t()} | {:error, term}
  def start(%Game{} = game) do
    GameSupervisor.start(game)
  end
end
