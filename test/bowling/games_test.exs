defmodule Bowling.GamesTest do
  use BowlingWeb.ConnCase, async: false

  alias Bowling.Games
  alias Bowling.Games.Models.Game

  describe "start/1" do
    test "on success" do
      game = %Game{id: "LANE-1", players: ["Maria", "Juan", "Rafael"]}

      expected_game = %Game{
        current_player: "Maria",
        current_turn: 1,
        id: "LANE-1",
        next_players: ["Juan", "Rafael"],
        players: ["Maria", "Juan", "Rafael"]
      }

      assert {:ok, expected_game} == Games.start(game)
    end

    test "error when the game is created" do
      game = %Game{id: "LANE-2", players: ["Maria", "Juan", "Rafael"]}
      assert {:ok, _game} = Games.start(game)

      assert {:error, :already_started} == Games.start(game)
    end
  end
end
