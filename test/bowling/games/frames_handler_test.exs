defmodule Bowling.Games.FramesHandlerTest do
  use BowlingWeb.ConnCase, async: false

  alias Bowling.Games.FramesHandler

  test "add_fallen_pins/2" do
    frames = []
    assert [[10]] == FramesHandler.add_fallen_pins(frames, 10)

    frames = [[10]]
    assert [[10], [7]] == FramesHandler.add_fallen_pins(frames, 7)

    frames = [[10], [7]]
    assert [[10], [7, 0]] == FramesHandler.add_fallen_pins(frames, 0)

    frames = [[10], [7, 0]]
    assert [[10], [7, 0], [10]] == FramesHandler.add_fallen_pins(frames, 10)

    frames = [[10], [7, 0], [10]]
    assert [[10], [7, 0], [10], [10]] == FramesHandler.add_fallen_pins(frames, 10)

    frames = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [0, 8], [0, 9], [10]]
    expected_frames = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [0, 8], [0, 9], [10, 10]]
    assert expected_frames == FramesHandler.add_fallen_pins(frames, 10)
  end
end
