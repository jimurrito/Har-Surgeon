defmodule HarSurgeonWeb.IndexHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use HarSurgeonWeb, :html

  embed_templates "html/*"
end
