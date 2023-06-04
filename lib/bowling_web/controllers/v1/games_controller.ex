defmodule BowlingWeb.V1.GamesController do
  use BowlingWeb, :controller

  alias Bowling

  alias __MODULE__.Params
  alias BowlingWeb.Controllers.{Helpers, Serializer}

  def create(conn, raw_params) do
    with {:ok, game} <- Params.parse_create(raw_params),
         {:ok, game} <- Bowling.start_game(game) do
      Helpers.json_resp(conn, :ok, %{game: Serializer.serialize(game)})
    else
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
      :not_found ->
        Helpers.json_resp(conn, :not_found)

      {:wrong_format, error} ->
        Helpers.json_resp(conn, :bad_request, error)

      _error ->
        Helpers.json_resp(conn, :server_error)
    end
  end
end
