defmodule AjedrezWeb.PageController do
  use AjedrezWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
