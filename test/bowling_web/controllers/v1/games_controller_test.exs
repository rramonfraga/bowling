defmodule BowlingWeb.V1.GamesControllerTest do
  use BowlingWeb.ConnCase, async: false

  describe "create/2" do
    test "on success", %{conn: conn} do
      id = "LANE-1W"

      raw_params = %{
        "game_id" => id,
        "players" => ["Maria", "Juan", "Rafael"]
      }

      expected_response = %{
        "game" => %{
          "id" => id,
          "players" => [
            %{"frames" => [], "name" => "Maria", "frame_scores" => 0, "total_score" => 0},
            %{"frames" => [], "name" => "Juan", "frame_scores" => 0, "total_score" => 0},
            %{"frames" => [], "name" => "Rafael", "frame_scores" => 0, "total_score" => 0}
          ],
          "current_player_name" => "Maria",
          "current_turn" => 1,
          "next_player_names" => ["Juan", "Rafael"]
        }
      }

      response =
        conn
        |> post(~p"/api/v1/game", raw_params)
        |> json_response(200)

      assert expected_response == response
    end

    test "on error when missing some field", %{conn: conn} do
      raw_params = %{"players" => ["Maria", "Juan", "Rafael"]}
      expected_response = %{"error" => "Bad Request: Field \"game_id\" is mandatory"}

      response =
        conn
        |> post(~p"/api/v1/game", raw_params)
        |> json_response(400)

      assert expected_response == response
    end

    test "on error when game_id is not a sting", %{conn: conn} do
      raw_params = %{"game_id" => 1234, "players" => ["Maria"]}
      expected_response = %{"error" => "Bad Request: Field \"game_id\" is not a string"}

      response =
        conn
        |> post(~p"/api/v1/game", raw_params)
        |> json_response(400)

      assert expected_response == response
    end

    test "on error when players is not a list of strings", %{conn: conn} do
      id = "LANE-1W"
      raw_params = %{"game_id" => id, "players" => "Maria"}
      expected_response = %{"error" => "Bad Request: Field \"players\" is not a list of strings"}

      response =
        conn
        |> post(~p"/api/v1/game", raw_params)
        |> json_response(400)

      assert expected_response == response
    end
  end

  describe "update/2" do
    test "on success", %{conn: conn} do
      game_id = "LANE-2W"
      game_params = %{"game_id" => game_id, "players" => ["Maria", "Juan", "Rafael"]}

      # Create Game
      post(conn, ~p"/api/v1/game", game_params)

      raw_params = %{"fallen_pins" => 8}

      expected_response = %{
        "game" => %{
          "id" => "LANE-2W",
          "players" => [
            %{"frames" => ['\b'], "name" => "Maria", "frame_scores" => [], "total_score" => 0},
            %{"frames" => [], "name" => "Juan", "frame_scores" => 0, "total_score" => 0},
            %{"frame_scores" => 0, "frames" => [], "name" => "Rafael", "total_score" => 0}
          ],
          "current_player_name" => "Maria",
          "current_turn" => 1,
          "next_player_names" => ["Juan", "Rafael"]
        }
      }

      response =
        conn
        |> patch(~p"/api/v1/game/#{game_id}", raw_params)
        |> json_response(200)

      assert expected_response == response
    end

    test "on error when not found", %{conn: conn} do
      game_id = "LANE-not-found-web"
      raw_params = %{"fallen_pins" => 8}
      expected_response = %{"error" => "Not Found"}

      response =
        conn
        |> patch(~p"/api/v1/game/#{game_id}", raw_params)
        |> json_response(404)

      assert expected_response == response
    end

    test "on error when missing some field", %{conn: conn} do
      game_id = "LANE-2W"
      raw_params = %{}
      expected_response = %{"error" => "Bad Request: Field \"fallen_pins\" is mandatory"}

      response =
        conn
        |> patch(~p"/api/v1/game/#{game_id}", raw_params)
        |> json_response(400)

      assert expected_response == response
    end

    test "on error when players ", %{conn: conn} do
      game_id = "LANE-2W"
      raw_params = %{"fallen_pins" => "2"}
      expected_response = %{"error" => "Bad Request: Field \"fallen_pins\" is not a integer"}

      response =
        conn
        |> patch(~p"/api/v1/game/#{game_id}", raw_params)
        |> json_response(400)

      assert expected_response == response
    end
  end
end
