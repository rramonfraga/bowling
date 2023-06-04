defmodule Bowling do
  @moduledoc """
  Bowling keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Bowling.Games

  defdelegate start_game(game),
    to: Bowling.Games,
    as: :start

  defdelegate add_fallen_pins(game_id, fallen_pins),
    to: Bowling.Games,
    as: :add_fallen_pins
end
