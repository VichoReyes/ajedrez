defmodule AjedrezWeb.PageController do
  use AjedrezWeb, :controller

  def home(conn, _params) do
    name = "example name"
    # position is a FEN code
    position = Ajedrez.Boards.get_fen(name)
    conn
    |> assign(:position, position)
    |> render(:home)
  end

  def update(conn, params) do
    name = "example name"
    {:ok, _} = Ajedrez.Boards.set_fen(name, params["position"])
    conn
    |> send_resp(:no_content, "")
  end
end
