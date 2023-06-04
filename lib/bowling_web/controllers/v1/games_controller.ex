defmodule BowlingWeb.V1.GamesController do
  use BowlingWeb, :controller

  alias __MODULE__.Params
  alias Bowling
  alias BowlingWeb.Controllers.{Helpers, Serializer}

  def create(conn, raw_params) do
    with {:ok, game} <- Params.parse_create(raw_params),
         {:ok, game} <- Bowling.start_game(game) do
      Helpers.json_resp(conn, :ok, %{game: Serializer.serialize(game)})
    else
      {:wrong_format, error} ->
        Helpers.json_resp(conn, :bad_request, error)

      :game_already_created ->
        Helpers.json_resp(conn, 409, %{error: "Game already created"})

      _error ->
        Helpers.json_resp(conn, :server_error)
    end
  end

  def show(conn, raw_params) do
    with {:ok, game_id} <- Params.parse_show(raw_params),
         {:ok, game} <- Bowling.find_game(game_id) do
      Helpers.json_resp(conn, :ok, %{game: Serializer.serialize(game)})
    else
      :not_found ->
        Helpers.json_resp(conn, :not_found)

      {:wrong_format, error} ->
        Helpers.json_resp(conn, :bad_request, error)

      _error ->
        Helpers.json_resp(conn, :server_error)
    end
  end

  def update(conn, raw_params) do
    with {:ok, game_id, fallen_pins} <- Params.parse_patch(raw_params),
         {:ok, game} <- Bowling.add_fallen_pins_in_a_game(game_id, fallen_pins) do
      Helpers.json_resp(conn, :ok, %{game: Serializer.serialize(game)})
    else
      :game_is_ended ->
        Helpers.json_resp(conn, 200, %{message: "GAME END"})

      :not_found ->
        Helpers.json_resp(conn, :not_found)

      {:wrong_format, error} ->
        Helpers.json_resp(conn, :bad_request, error)

      _error ->
        Helpers.json_resp(conn, :server_error)
    end
  end
end
