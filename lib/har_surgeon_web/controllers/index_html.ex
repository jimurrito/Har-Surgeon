defmodule HarSurgeonWeb.IndexHTML do
  @moduledoc false

  use HarSurgeonWeb, :html
  import HarSurgeonWeb.DisplayComponents
  import HarSurgeonWeb.RenderComponents

  embed_templates "html/*"
end
