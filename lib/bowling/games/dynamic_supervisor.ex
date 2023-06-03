defmodule Bowling.Games.DynamicSupervisor do
  @moduledoc """
  Supervisor for each game
  """

  use DynamicSupervisor

  alias __MODULE__.Worker

  def start_link(init_arg \\ []) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def child_spec(opts \\ []) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker
    }
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start(game) do
    case start_child(game) do
      {:ok, _pid} -> {:ok, game}
      {:error, {:already_started, _pid}} -> {:error, :already_started}
      _ -> {:error, :internal_error}
    end
  end

  defp start_child(game) do
    DynamicSupervisor.start_child(__MODULE__, %{
      id: Worker,
      start: {Worker, :start_link, [game]},
      restart: :transient
    })
  end
end
