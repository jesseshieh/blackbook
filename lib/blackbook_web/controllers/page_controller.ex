defmodule BlackbookWeb.PageController do
  use BlackbookWeb, :controller

#  def action(conn, _) do
#    apply(__MODULE__, action_name(conn),
#      [conn, conn.params, conn.assigns.current_user])
#  end

  def index(conn, _params) do
    IO.inspect(conn)
    render(conn, "index.html")
  end
end
