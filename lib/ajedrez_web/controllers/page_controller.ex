defmodule AjedrezWeb.PageController do
  use AjedrezWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end

  def show(conn, %{"name" => name}) do
    # position is a FEN code
    position = Ajedrez.Boards.get_fen(name)
    conn
    |> assign(:position, position)
    |> render(:show)
  end

  def update(conn, %{"name" => name} = params) do
    {:ok, _} = Ajedrez.Boards.set_fen(name, params["position"])
    conn
    |> send_resp(:no_content, "")
  end
end
