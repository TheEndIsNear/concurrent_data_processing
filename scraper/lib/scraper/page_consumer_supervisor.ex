defmodule Scraper.PageConsumerSupervisor do
  use ConsumerSupervisor
  require Logger

  alias Scraper.{PageConsumer, OnlinePageProducerConsumer}

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

    opts = [
      strategy: :one_for_one,
      subscribe_to: [
        {OnlinePageProducerConsumer.via("online_page_producer_consumer_1"), []},
        {OnlinePageProducerConsumer.via("online_page_producer_consumer_2"), []}
      ]
    ]

    ConsumerSupervisor.init(children, opts)
  end
end
