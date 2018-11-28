defmodule Blackbook.Plugs.RequireAuth do

    import Plug.Conn
    import Phoenix.Controller
    alias BlackbookWeb.Router.Helpers, as: Routes

    def init(_params) do

    end

    def call(conn, _params) do
        IO.puts("++++")
        IO.inspect(conn.assigns)
        IO.puts("++++")
        if conn.assigns[:current_user] do
            conn
        else
            conn
            |> put_flash(:error, "You must be logged in.")
            |> redirect(to: Routes.session_path(conn, :new))
            |> halt()
        end
    end

end