defmodule Tickets.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Tickets.{BookingsPipeline, NotificationsPipeline}

  @impl true
  def start(_type, _args) do
    children = [
      BookingsPipeline,
      NotificationsPipeline
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tickets.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
