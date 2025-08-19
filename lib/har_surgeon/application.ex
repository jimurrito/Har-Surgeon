defmodule HarSurgeon.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HarSurgeonWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:har_surgeon, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HarSurgeon.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: HarSurgeon.Finch},
      # Start a worker by calling: HarSurgeon.Worker.start_link(arg)
      # {HarSurgeon.Worker, arg},
      # Start to serve requests, typically the last entry
      HarSurgeonWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HarSurgeon.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HarSurgeonWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
