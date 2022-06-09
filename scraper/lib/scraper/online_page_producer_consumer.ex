defmodule Scraper.OnlinePageProducerConsumer do
  use Flow
  require Logger

  alias Scraper.PageProducer

  def start_link(_args) do
    [Process.whereis(PageProducer)]
    |> Flow.from_stages(max_demand: 1, stages: 2)
    |> Flow.filter(&Scraper.online?/1)
    |> Flow.map(&Scraper.work/0)
  end
end
