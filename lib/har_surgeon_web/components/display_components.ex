defmodule HarSurgeonWeb.DisplayComponents do
  @moduledoc """
  Components to help display values or configure object color based on JSON data.
  """

  use Phoenix.Component
  use Gettext, backend: HarSurgeonWeb.Gettext

  #
  #
  @doc """
  Provides a CSS background color based on the HTTP method provided.
  """
  @spec method_color(binary()) :: binary()
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

  #
  #
  @doc """
  Formats JSON (text or map) into a pretty-formatted JSON string.
  """
  @spec format_json(binary() | map()) :: binary()
  def format_json(raw) when is_binary(raw) do
    case Jason.decode(raw) do
      {:ok, parsed} -> Jason.encode!(parsed, pretty: true)
      _ -> raw
    end
  end

  def format_json(raw) do
    Jason.encode!(raw, pretty: true)
  end

  #
  #
  @doc """
  If status code provided is 400 or higher, the return CSS will be `text-red-700 font-bold`.
  Otherwise the return will be an empty string.
  """
  @spec error_color_text(non_neg_integer()) :: binary()
  def error_color_text(status_code) do
    cond do
      status_code >= 400 -> "text-red-700 font-bold"
      true -> ""
    end
  end

  #
  #
  @doc """
  Truncates text that is longer then the provided limit.
  Default limit is `225` characters.
  """
  @spec truncate_text(binary(), non_neg_integer()) :: binary()
  def truncate_text(text, limit \\ 100) do
    if String.length(text) > limit do
      {keep, _trash} = String.split_at(text, limit)
      "#{keep} ..."
    else
      text
    end
  end

  #
  #
  @doc """
  Formats floats and integer based data sizes.
  """
  @spec format_data_size(integer() | float()) :: binary()
  def format_data_size(data_size) do
    cond do
      data_size > 1_000_000_000 -> "#{data_size / 1_000_000_000} GB"
      data_size > 1_000_000 -> "#{data_size / 1_000_000} MB"
      data_size > 1_000 -> "#{data_size / 1000} KB"
      true -> "#{data_size} B"
    end
  end
end
