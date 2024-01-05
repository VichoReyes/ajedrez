defmodule AjedrezWeb.PageController do
  use AjedrezWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def update(conn, params) do
    IO.puts("FEN: #{params["position"]}")
    conn
    |> send_resp(:no_content, "")
  end
end
