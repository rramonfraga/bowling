defmodule Bowling.Games.Models.Game do
  @moduledoc """
  Game model structure
  """

  alias Bowling.Games.Models.Player

  @type current_player_name :: Player.name()
  @type current_turn :: integer
  @type id :: String.t()
  @type next_player_names :: [Player.name()]
  @type players :: [Player.t()]

  @type t :: %__MODULE__{
          current_player_name: current_player_name,
          current_turn: current_turn,
          id: id,
          next_player_names: next_player_names,
          players: players
        }

  defstruct current_player_name: nil,
            current_turn: 0,
            id: nil,
            next_player_names: [],
            players: []
end
