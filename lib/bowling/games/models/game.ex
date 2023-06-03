defmodule Bowling.Games.Models.Game do
  @moduledoc """
  Game model structure
  """

  alias Bowling.Games.Models.Player

  @type current_player :: Player.name()
  @type current_turn :: integer
  @type id :: String.t()
  @type next_players :: [Player.name()]
  @type players :: [Player.t()]

  @type t :: %__MODULE__{
          current_player: current_player,
          current_turn: current_turn,
          id: id,
          next_players: next_players,
          players: players
        }

  defstruct [
    current_player: nil,
    current_turn: 0,
    id: nil,
    next_players: [],
    players: []
  ]
end
