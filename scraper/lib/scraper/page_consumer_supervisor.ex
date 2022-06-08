defmodule Scraper.PageConsumerSupervisor do
  use ConsumerSupervisor
  require Logger

  alias Scraper.{PageConsumer, PageProducer}

  def start_link(_args) do
    ConsumerSupervisor.start_link(__MODULE__, :ok)
  end

  @impl true
  def init(:ok) do
    Logger.info("PageConsumerSupervisor init")

    children = [
      %{
        id: PageConsumer,
        start: {PageConsumer, :start_link, []},
        restart: :transient
      }
    ]

    max_demand = System.schedulers_online() * 2

    opts = [
      strategy: :one_for_one,
      subscribe_to: [
        {PageProducer, max_demand: max_demand}
      ]
    ]

    ConsumerSupervisor.init(children, opts)
  end
end
