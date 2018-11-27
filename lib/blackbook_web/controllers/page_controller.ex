defmodule BlackbookWeb.PageController do
  use BlackbookWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
