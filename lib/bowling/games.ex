defmodule Bowling.Games do
  @moduledoc """
  Business API for create, update and read games
  """
  alias Bowling.Games.DynamicSupervisor, as: GameSupervisor
  alias Bowling.Games.DynamicSupervisor.Worker, as: GameWorker
  alias Bowling.Games.Handler, as: GameHandler
  alias Bowling.Games.Models.Game

  @spec start(Game.t()) :: {:ok, Game.t()} | {:error, term}
  def start(%Game{} = game) do
    case GameHandler.set_turn(game) do
      {:ok, game} -> GameSupervisor.start(game)
      error -> error
    end
  end

  @spec add_fallen_pins(Game.id(), integer) :: {:ok, Game.t()} | {:error, term}
  def add_fallen_pins(game_id, fallen_pins) do
    with {:ok, game} <- GameWorker.fetch_by_id(game_id),
         {:ok, game} <- GameHandler.add_fallen_pins(game, fallen_pins),
         {:ok, game} <- GameHandler.set_turn(game),
         {:ok, game} <- GameWorker.update(game) do
      {:ok, game}
    end
  end

  @spec find(Game.id()) :: {:ok, Game.t()} | {:error, term}
  def find(game_id) do
    GameWorker.fetch_by_id(game_id)
  end
end
