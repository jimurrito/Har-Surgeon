defmodule HarSurgeonWeb.RenderComponents do
  @moduledoc """
  Components to help render the HAR file JSON data.
  """

  use Phoenix.Component
  use Gettext, backend: HarSurgeonWeb.Gettext
  import HarSurgeonWeb.DisplayComponents

  def json_block(assigns) do
    ~H"""
    <pre class="bg-gray-50 p-3 rounded-lg text-xs overflow-x-auto border border-gray-200">
    {@input |> format_json()}</pre>
    """
  end
end
