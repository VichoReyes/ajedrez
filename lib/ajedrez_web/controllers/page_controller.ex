defmodule AjedrezWeb.PageController do
  use AjedrezWeb, :controller

  def home(conn, _params) do
    # position is a FEN code
    position = Ajedrez.PositionStore.get()
    conn
    |> assign(:position, position)
    |> render(:home)
  end

  def update(conn, params) do
    Ajedrez.PositionStore.set(params["position"])
    conn
    |> send_resp(:no_content, "")
  end
end
