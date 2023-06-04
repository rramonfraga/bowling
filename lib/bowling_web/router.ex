defmodule BowlingWeb.Router do
  use BowlingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", BowlingWeb.V1 do
    pipe_through :api

    post("/game", GamesController, :create)
    get("/game/:game_id", GamesController, :show)
    patch("/game/:game_id", GamesController, :update)
  end
end
