defmodule HarSurgeon.Tracker do
  @moduledoc """
  Presence and Session tracker.
  """

  use Agent
  require Logger

  #
  #
  @doc """
  Entry point for Supervisor
  """
  @spec start_link(any()) :: Agent.on_start()
  def start_link(_args) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  #
  #
  @doc """
  Creates a new login record to be tracked. Stores the JSON data if available.
  Returns tracking ID for the front end to query from.
  """
  @spec new(map()) :: binary()
  def new(json \\ %{}) do
    trackingid = UUID.uuid4()
    :ok = update(trackingid, json)
    trackingid
  end

  #
  #
  @doc """
  Updates the cache for uploaded JSON data.
  """
  @spec update(binary(), map()) :: :ok
  def update(trackingid, json) do
    Agent.update(__MODULE__, &(&1 |> Map.put(trackingid, json)))
  end

  #
  #
  @doc """
  Retrieves data from a Tracking ID
  """
  @spec get(binary()) :: map()
  def get(trackingid) do
    Agent.get(__MODULE__, &(&1 |> Map.get(trackingid)))
  end
end
