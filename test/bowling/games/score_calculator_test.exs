defmodule Bowling.Games.ScoreCalculatorTest do
  use BowlingWeb.ConnCase, async: false

  alias Bowling.Games.ScoreCalculator

  test "calculate/2" do
    frames = []
    assert {[], 0} == ScoreCalculator.calculate(frames)

    frames = [[1, 2]]
    assert {[3], 3} == ScoreCalculator.calculate(frames)

    frames = [[1, 2], [5]]
    assert {[3], 3} == ScoreCalculator.calculate(frames)

    frames = [[1, 2], [5, 4]]
    assert {[3, 9], 12} == ScoreCalculator.calculate(frames)

    frames = [[0, 10]]
    assert {[], 0} == ScoreCalculator.calculate(frames)

    frames = [[0, 10], [5]]
    assert {[15], 15} == ScoreCalculator.calculate(frames)

    frames = [[0, 10], [5, 3]]
    assert {[15, 8], 23} == ScoreCalculator.calculate(frames)

    frames = [[10]]
    assert {[], 0} == ScoreCalculator.calculate(frames)

    frames = [[10], [5]]
    assert {[], 0} == ScoreCalculator.calculate(frames)

    frames = [[10], [5, 3]]
    assert {[18, 8], 26} == ScoreCalculator.calculate(frames)

    frames = [[10], [5, 5], [1, 9], [5]]
    assert {[20, 11, 15], 46} == ScoreCalculator.calculate(frames)

    frames = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [0, 8], [0, 9], [5, 5, 5]]
    assert {[1, 2, 3, 4, 5, 6, 7, 8, 9, 15], 60} == ScoreCalculator.calculate(frames)

    frames = [[10], [10], [10], [10], [10], [10], [10], [10], [10], [1, 0]]
    assert {[30, 30, 30, 30, 30, 30, 30, 21, 11, 1], 243} == ScoreCalculator.calculate(frames)

    frames = [[10], [10], [10], [10], [10], [10], [10], [10], [10], [10, 10, 10]]
    assert {[30, 30, 30, 30, 30, 30, 30, 30, 30, 30], 300} == ScoreCalculator.calculate(frames)
  end
end
