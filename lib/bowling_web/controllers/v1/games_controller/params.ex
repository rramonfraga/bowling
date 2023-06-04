defmodule BowlingWeb.V1.GamesController.Params do
  @moduledoc """
  Module for parse params from games controller
  """

  alias Bowling.Games.Models.{Game, Player}

  def parse_create(raw_params) do
    with {:ok, game_id} <- parse_game_id(raw_params),
         {:ok, players} <- parse_players(raw_params) do
      {:ok, build_game(game_id, players)}
    end
  end

  defp build_game(game_id, players) do
    %Game{id: game_id, players: Enum.map(players, &%Player{name: &1})}
  end

  defp parse_game_id(data) do
    with {:ok, game_id} <- Map.fetch(data, "game_id"),
         {:is_binary, true} <- {:is_binary, is_binary(game_id)} do
      {:ok, game_id}
    else
      :error -> {:wrong_format, presence_error("game_id")}
      {:is_binary, false} -> {:wrong_format, string_error("game_id")}
    end
  end

  defp parse_players(data) do
    with {:ok, players} <- Map.fetch(data, "players"),
         :is_list_of_strings <- is_list_of_strings(players) do
      {:ok, players}
    else
      :error -> {:wrong_format, presence_error("players")}
      :is_not_list_of_strings -> {:wrong_format, list_of_strings_error("players")}
    end
  end

  defp is_list_of_strings(value) do
    case is_list(value) && Enum.all?(value, &is_binary(&1)) do
      true -> :is_list_of_strings
      false -> :is_not_list_of_strings
    end
  end

  defp presence_error(field),
    do: ~s[Field "#{field}" is mandatory]

  defp string_error(field),
    do: ~s[Field "#{field}" is not a string]

  defp list_of_strings_error(field),
    do: ~s[Field "#{field}" is not a list of strings]
end
