defmodule Bowling.Games.Handler do
  @moduledoc """
  Module to handle how the game continue.
  """
  alias Bowling.Games.Models.Game

  alias Bowling.Games.{
    FramesHandler,
    PlayersHandler,
    ScoreCalculator
  }

  def set_turn(
        %Game{
          current_turn: current_turn,
          next_players: [],
          players: [current_player | rest_players]
        } = game
      ) do
    %{
      game
      | current_player: current_player.name,
        current_turn: current_turn + 1,
        next_players: Enum.map(rest_players, &(&1.name))
    }
  end

  def set_turn(%Game{next_players: [current_player | rest_players]} = game) do
    %{game | current_player: current_player, next_players: rest_players}
  end

  def add_fallen_pins(
        %Game{current_player: current_player_name, current_turn: current_turn} = game,
        fallen_pins
      ) do
    with current_player <- find_player(game, current_player_name),
         {:ok, frames} <- FramesHandler.add_fallen_pins(current_player.frames, fallen_pins),
         {frame_scores, total_score} <- ScoreCalculator.calculate(frames),
         {:ok, player} <-
           PlayersHandler.update(current_player, frame_scores, frames, total_score),
         game <- update_players(game, player) do
      case PlayersHandler.continue_playing?(player, current_turn) do
        :continue -> {:ok, game}
        :next_turn -> {:ok, set_turn(game)}
      end
    end
  end

  defp update_players(%Game{players: players} = game, updated_player) do
    players =
      Enum.map(players, fn player ->
        if player.name == updated_player.name do
          updated_player
        else
          player
        end
      end)

    %{game | players: players}
  end

  defp find_player(%Game{players: players}, current_player_name) do
    Enum.find(players, &(&1.name == current_player_name))
  end
end
