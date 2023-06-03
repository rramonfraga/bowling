defmodule Bowling.Games.ScoreCalculator do
  @moduledoc """
  Module to handle how add fallen pins in each frame.
  """
  def calculate(frames) do
    scores = do_calculate(frames, [])
    {scores, Enum.sum(scores)}
  end

  defp do_calculate([[thrown_1, thrown_2, thrown_3] | _tail], scores) do
    scores ++ [thrown_1 + thrown_2 + thrown_3]
  end

  defp do_calculate([[10, _thrown_1] | _tail], scores) do
    scores
  end

  defp do_calculate([[10], [thrown_1, thrown_2, thrown_3] | _tail], scores) do
    new_scores = scores ++ [10 + thrown_1 + thrown_2]
    do_calculate([[thrown_1, thrown_2, thrown_3]], new_scores)
  end

  defp do_calculate([[10], [10], [thrown_1, thrown_2, thrown_3] | _tail], scores) do
    new_scores = scores ++ [10 + 10 + thrown_1]
    do_calculate([[10], [thrown_1, thrown_2, thrown_3]], new_scores)
  end

  defp do_calculate([[10], [10], [thrown_1, thrown_2] | tail], scores) do
    new_scores = scores ++ [10 + 10 + thrown_1]
    do_calculate([[10], [thrown_1, thrown_2] | tail], new_scores)
  end

  defp do_calculate([[10], [10], [thrown_1] | tail], scores) do
    new_scores = scores ++ [10 + 10 + thrown_1]
    do_calculate([[10], [thrown_1] | tail], new_scores)
  end

  defp do_calculate([[10], [thrown_1, thrown_2] | tail], scores) do
    new_scores = scores ++ [10 + thrown_1 + thrown_2]
    do_calculate([[thrown_1, thrown_2] | tail], new_scores)
  end

  defp do_calculate([[10], [thrown_1] | tail], scores) do
    do_calculate([[thrown_1] | tail], scores)
  end

  defp do_calculate([[thrown_1, thrown_2], [next_thrown_1, next_thrown_2] | tail], scores)
       when thrown_1 + thrown_2 == 10 do
    new_scores = scores ++ [thrown_1 + thrown_2 + next_thrown_1]
    do_calculate([[next_thrown_1, next_thrown_2] | tail], new_scores)
  end

  defp do_calculate([[thrown_1, thrown_2], [next_thrown_1] | tail], scores)
       when thrown_1 + thrown_2 == 10 do
    new_scores = scores ++ [thrown_1 + thrown_2 + next_thrown_1]
    do_calculate([[next_thrown_1] | tail], new_scores)
  end

  defp do_calculate([[thrown_1, thrown_2] | tail], scores) when thrown_1 + thrown_2 < 10 do
    new_scores = scores ++ [thrown_1 + thrown_2]
    do_calculate(tail, new_scores)
  end

  defp do_calculate([_ | _], scores) do
    scores
  end

  defp do_calculate([], scores) do
    scores
  end
end
