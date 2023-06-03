defmodule Bowling.Games do
  @moduledoc """
  Business API for create, update and read games
  """
  alias Bowling.Games.DynamicSupervisor, as: GameSupervisor
  alias Bowling.Games.Handler
  alias Bowling.Games.Models.Game

  @spec start(Game.t()) :: {:ok, Game.t()} | {:error, term}
  def start(%Game{} = game) do
    game
    |> Handler.set_turn()
    |> GameSupervisor.start()
  end
end
