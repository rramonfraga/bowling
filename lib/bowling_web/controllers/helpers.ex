defmodule BowlingWeb.Controllers.Helpers do
  @moduledoc false

  alias BowlingWeb.Controllers.Serializer

  def json_resp(conn, :server_error),
    do: json_resp(conn, 500, Serializer.internal_error())

  def json_resp(conn, :ok, message),
    do: json_resp(conn, 200, message)

  def json_resp(conn, :bad_request, message),
    do: json_resp(conn, 400, Serializer.bad_request(message))

  def json_resp(conn, status, message) do
    conn
    |> Plug.Conn.put_status(status)
    |> Phoenix.Controller.json(message)
  end
end
