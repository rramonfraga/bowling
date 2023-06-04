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

  def set_turn(%Game{current_turn: current_turn} = game) do
    game
    |> find_current_player()
    |> PlayersHandler.continue_playing?(current_turn)
    |> case do
      :continue -> {:ok, game}
      :next_turn -> {:ok, do_set_turn(game)}
    end
  end

  defp do_set_turn(
         %Game{
           current_turn: current_turn,
           next_player_names: [],
           players: [current_player | rest_players]
         } = game
       ) do
    %{
      game
      | current_player_name: current_player.name,
        current_turn: current_turn + 1,
        next_player_names: Enum.map(rest_players, & &1.name)
    }
  end

  defp do_set_turn(%Game{next_player_names: [current_player_name | rest_player_names]} = game) do
    %{game | current_player_name: current_player_name, next_player_names: rest_player_names}
  end

  def add_fallen_pins(game, fallen_pins) do
    with current_player <- find_current_player(game),
         {:ok, frames} <- FramesHandler.add_fallen_pins(current_player.frames, fallen_pins),
         {frame_scores, total_score} <- ScoreCalculator.calculate(frames),
         {:ok, player} <-
           PlayersHandler.update(current_player, frame_scores, frames, total_score),
         game <- update_players(game, player) do
      {:ok, game}
    end
  end

  defp find_current_player(%Game{current_player_name: current_player_name, players: players}) do
    Enum.find(players, &(&1.name == current_player_name))
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
end
