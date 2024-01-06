defmodule Ajedrez.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AjedrezWeb.Telemetry,
      # Start the Ecto repository
      Ajedrez.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ajedrez.PubSub},
      # Start Finch
      {Finch, name: Ajedrez.Finch},
      # Start the Endpoint (http/https)
      AjedrezWeb.Endpoint,
      # Start a worker by calling: Ajedrez.Worker.start_link(arg)
      # {Ajedrez.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ajedrez.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AjedrezWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
