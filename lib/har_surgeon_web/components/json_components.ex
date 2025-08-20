defmodule HarSurgeonWeb.JsonComponents do
  @moduledoc """
  Components to help render the HAR file JSON data.
  """

  use Phoenix.Component
  use Gettext, backend: HarSurgeonWeb.Gettext

  def method_color(method) do
    method
    |> case do
      "GET" -> "bg-green-100 hover:bg-green-200"
      "POST" -> "bg-blue-100 hover:bg-blue-200"
      "PUT" -> "bg-yellow-100 hover:bg-yellow-200"
      "DELETE" -> "bg-red-100 hover:bg-red-200"
      "PATCH" -> "bg-orange-100 hover:bg-orange-200"
      "OPTIONS" -> "bg-purple-100 hover:bg-purple-200"
      "HEAD" -> "bg-gray-200 hover:bg-gray-300"
      _ -> "bg-gray-100 hover:bg-gray-200"
    end
  end

  def format_json(raw) when is_binary(raw) do
    case Jason.decode(raw) do
      {:ok, parsed} -> Jason.encode!(parsed, pretty: true)
      _ -> raw
    end
  end

  def format_json(raw) do
    Jason.encode!(raw, pretty: true)
  end
end
