defmodule Bowling.Games.Models.Player do
  @moduledoc """
  Player model structure
  """

  @type frame_scores :: [integer]
  @type frames :: [[integer]]
  @type name :: String.t()
  @type total_score :: integer

  @type t :: %__MODULE__{
          frame_scores: frame_scores,
          frames: frames,
          name: name,
          total_score: total_score
        }

  defstruct frame_scores: 0,
            frames: [],
            name: nil,
            total_score: 0
end
