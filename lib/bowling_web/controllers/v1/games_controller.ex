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
end
