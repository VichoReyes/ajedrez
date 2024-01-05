defmodule Ajedrez.PositionStore do
  @moduledoc """
  PositionStore is responsible for storing and retrieving chess positions, stored as FEN codes.
  """
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    {:ok, "8/8/8/8/8/8/8/8"}
  end

  def get() do
    GenServer.call(__MODULE__, :get)
  end

  def set(position) do
    GenServer.call(__MODULE__, {:set, position})
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:set, position}, _from, _state) do
    {:reply, :ok, position}
  end
end
