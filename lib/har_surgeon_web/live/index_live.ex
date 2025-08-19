defmodule HarSurgeonWeb.IndexLive do
  @moduledoc false

  use HarSurgeonWeb, :live_view
  alias Phoenix.LiveView.AsyncResult

  #
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  #
  # Callbacks
  #

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  #
  #
  # handles async responses
  @impl true
  def handle_async(assign, msg, socket) do
    result = async_assign(socket, assign, msg)
    {:noreply, result}
  end

  #
  #
  # Renders the primary doc for the page
  @impl true
  def render(assigns) do
    ~H"""
    <div class="grid grid-cols-[640px_1fr_300px] gap-2 items-start">
      <div>yo</div>
    </div>
    """
  end

  #
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  #
  # Internal func
  #

  #
  #
  @doc """
  Handles generic async assigns.
  Successful assigns are pushed as-is to the assigns value in the socket.
  """
  def async_assign(socket, assign, msg) do
    msg
    |> case do
      # job finished successfully
      {:ok, assign_response} ->
        fetched = assign_response |> Map.get(assign)
        update(socket, assign, &AsyncResult.ok(&1, fetched))

      # failed to complete
      {:exit, reason} ->
        update(socket, assign, &AsyncResult.failed(&1, {:exit, reason}))
    end
  end
end
