defmodule Bowling.Games.Handler do
  @moduledoc """
  Module to handle how the game continue.
  """
  alias Bowling.Games.Models.Game

  def set_turn(%Game{current_turn: current_turn, next_players: [], players: [current_player | rest_players]} = game) do
    %{game | current_player: current_player, current_turn: current_turn + 1, next_players: rest_players}
  end

  def set_turn(%Game{next_players: [current_player | rest_players]} = game) do
    %{game | current_player: current_player, next_players: rest_players}
  end
end
