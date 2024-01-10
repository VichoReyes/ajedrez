defmodule Ajedrez.DatabaseCleanupWorker do
  require Logger
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    schedule_cleanup()
    {:ok, :ok}
  end

  def handle_info(:cleanup, state) do
    # a board is considered stale if it hasn't been updated in 3 hours
    {deleted, _} = Ajedrez.Boards.cleanup(3 * 60 * 60)
    if deleted do
      Logger.info("Cleaning up database, deleted #{deleted} boards")
    end
    schedule_cleanup()
    {:noreply, state}
  end

  defp schedule_cleanup() do
    # cleanup every half hour
    Process.send_after(self(), :cleanup, 30 * 60 * 1000)
  end
end
