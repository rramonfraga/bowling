defmodule BowlingWeb.Controllers.Serializer do
  @moduledoc false

  def serialize(list) when is_list(list) do
    Enum.map(list, &serialize/1)
  end

  def serialize(%{__struct__: _} = struct) do
    struct
    |> Map.from_struct()
    |> Map.new(fn {key, value} -> {key, serialize(value)} end)
  end

  def serialize(data) do
    data
  end

  def not_found() do
    %{error: "Not Found"}
  end

  def bad_request(error) do
    %{error: "Bad Request: #{error}"}
  end

  def internal_error() do
    %{error: "Internal Server Error"}
  end
end
