defmodule Bowling.Games.PlayersHandlerTest do
  use BowlingWeb.ConnCase, async: false

  alias Bowling.Games.Models.Player

  alias Bowling.Games.PlayersHandler

  describe "continue_playing?/2" do
    test "continue" do
      frames = [[1,2], [1]]
      player = %Player{frames: frames}
      assert :continue == PlayersHandler.continue_playing?(player, 1)

      frames = [[10], [10], [10], [10], [10], [10], [10], [10], [10], [10]]
      player = %Player{frames: frames}
      assert :continue == PlayersHandler.continue_playing?(player, 10)

      frames = [[10], [10], [10], [10], [10], [10], [10], [10], [10], [10, 10]]
      player = %Player{frames: frames}
      assert :continue == PlayersHandler.continue_playing?(player, 10)

      frames = [[10], [10], [10], [10], [10], [10], [10], [10], [10], [5, 5]]
      player = %Player{frames: frames}
      assert :continue == PlayersHandler.continue_playing?(player, 10)
    end

    test "next turn" do
      frames = [[10]]
      player = %Player{frames: frames}
      assert :next_turn == PlayersHandler.continue_playing?(player, 1)

      frames = [[1, 2], [1, 2]]
      player = %Player{frames: frames}
      assert :next_turn == PlayersHandler.continue_playing?(player, 1)

      frames = [[10], [10], [10], [10], [10], [10], [10], [10], [10], [0, 0]]
      player = %Player{frames: frames}
      assert :next_turn == PlayersHandler.continue_playing?(player, 10)
    end
  end
end
