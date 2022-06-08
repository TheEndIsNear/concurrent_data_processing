defmodule Scraper.PageConsumer do
  use GenStage
  require Logger
  alias Scraper.PageProducer

  def start_link(event) do
    Logger.info("PageConsumer received #{event}")

    Task.start_link(fn ->
      Scraper.work()
    end)
  end
end
