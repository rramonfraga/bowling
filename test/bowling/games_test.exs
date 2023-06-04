defmodule Bowling.GamesTest do
  use BowlingWeb.ConnCase, async: false

  alias Bowling.Games
  alias Bowling.Games.Models.Game
  alias Bowling.Games.Models.Player

  describe "start/1" do
    test "on success" do
      players = [%Player{name: "Maria"}, %Player{name: "Juan"}, %Player{name: "Rafael"}]
      game = %Game{id: "LANE-1", players: players}

      expected_game = %Game{
        current_player_name: "Maria",
        current_turn: 1,
        id: "LANE-1",
        next_player_names: ["Juan", "Rafael"],
        players: players
      }

      assert {:ok, expected_game} == Games.start(game)
    end

    test "error when the game is created" do
      players = [%Player{name: "Maria"}, %Player{name: "Juan"}, %Player{name: "Rafael"}]
      game = %Game{id: "LANE-2", players: players}
      assert {:ok, _game} = Games.start(game)

      assert {:error, :already_started} == Games.start(game)
    end
  end

  describe "add_fallen_pins/2" do
    test "on success" do
      id = "LANE-3"
      players = [%Player{name: "Maria"}, %Player{name: "Juan"}]
      game = %Game{id: id, players: players}
      assert {:ok, _game} = Games.start(game)

      expected_game_1 = %Game{
        current_player_name: "Maria",
        current_turn: 1,
        id: id,
        next_player_names: ["Juan"],
        players: [
          %Player{frame_scores: [], frames: [[9]], name: "Maria", total_score: 0},
          %Player{name: "Juan"}
        ]
      }

      assert {:ok, expected_game_1} == Games.add_fallen_pins(id, 9)

      Games.add_fallen_pins(id, 0)
      Games.add_fallen_pins(id, 5)
      Games.add_fallen_pins(id, 5)
      Games.add_fallen_pins(id, 7)
      Games.add_fallen_pins(id, 1)
      Games.add_fallen_pins(id, 8)

      expected_game_2 = %Game{
        current_player_name: "Maria",
        current_turn: 3,
        id: id,
        next_player_names: ["Juan"],
        players: [
          %Player{frame_scores: [9, 8], frames: [[9, 0], [7, 1]], name: "Maria", total_score: 17},
          %Player{frame_scores: [18, 8], frames: [[5, 5], [8, 0]], name: "Juan", total_score: 26}
        ]
      }

      assert {:ok, expected_game_2} == Games.add_fallen_pins(id, 0)
    end

    test "not found" do
      id = "LANE-not-found"
      assert :not_found == Games.add_fallen_pins(id, 0)
    end
  end
end
