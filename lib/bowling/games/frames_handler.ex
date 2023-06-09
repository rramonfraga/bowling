defmodule Bowling.Games.FramesHandler do
  @moduledoc """
  Module to handle how add fallen pins in each frame.
  """

  def add_fallen_pins(_frames, fallen_pins) when fallen_pins < 0 or 10 < fallen_pins do
    :invalid_fallend_pins
  end

  def add_fallen_pins(frames, fallen_pins) do
    case Enum.count(frames) do
      turn when -1 < turn and turn < 11 -> do_add_fallen_pins(frames, fallen_pins)
      _ -> :invalid_turn
    end
  end

  defp do_add_fallen_pins(frames, fallen_pins) do
    frames
    |> add_or_update_frame?()
    |> do_action(frames, fallen_pins)
  end

  defp add_or_update_frame?(frames) do
    turn = Enum.count(frames)
    frame = List.last(frames)

    case {frame, turn} do
      {nil, _turn} -> :add
      {[10], 10} -> :update
      {[10], _turn} -> :add
      {[10, _number], 10} -> :update
      {[_number_1, _number_2, _number_3], 10} -> :invalid
      {[_number_1], _turn} -> :update
      {[number_1, number_2], 10} when number_1 + number_2 == 10 -> :update
      {[_number_1, _number_2], 10} -> :invalid
      {[_number_1, _number_2], _turn} -> :add
    end
  end

  defp do_action(:add, frames, fallen_pins) do
    {:ok, frames ++ [[fallen_pins]]}
  end

  defp do_action(:update, frames, fallen_pins) do
    {:ok, List.update_at(frames, -1, &(&1 ++ [fallen_pins]))}
  end

  defp do_action(:invalid, _frams, _fallen_pins) do
    :invalid_turn
  end
end
