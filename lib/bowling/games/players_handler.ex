defmodule Bowling.Games.PlayersHandler do
  @moduledoc """
  Module to handle and update players
  """
  alias Bowling.Games.Models.Player

  def update(player, frame_scores, frames, total_score) do
    {:ok, %{player | frame_scores: frame_scores, frames: frames, total_score: total_score}}
  end

  def continue_playing?(nil, _turn) do
    :next_turn
  end

  def continue_playing?(%Player{frames: frames}, turn) do
    frames
    |> List.last()
    |> do_continue_playing?(turn)
  end

  defp do_continue_playing?([10], 10), do: :continue
  defp do_continue_playing?([10, _thrown_2], 10), do: :continue

  defp do_continue_playing?([thrown_1, thrown_2], 10) when thrown_1 + thrown_2 == 10,
    do: :continue

  defp do_continue_playing?([10], _turn), do: :next_turn
  defp do_continue_playing?([_thrown_1, _thrown_2], _turn), do: :next_turn
  defp do_continue_playing?(_frame, _turn), do: :continue
end
