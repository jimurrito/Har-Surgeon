defmodule HarSurgeonWeb.IndexHTML do
  @moduledoc false

  use HarSurgeonWeb, :html
  import HarSurgeonWeb.JsonComponents

  embed_templates "html/*"
end
