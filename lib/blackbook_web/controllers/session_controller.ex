defmodule BlackbookWeb.SessionController do
    use BlackbookWeb, :controller

    alias Blackbook.Session

    def new(conn, _params) do
        render conn, "new.html"
    end

    def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
        case Blackbook.Session.authenticate_user(email, password) do
            {:ok, user} ->
                conn
                |> Blackbook.Session.login(user)
                |> put_flash(:info, "Logged in")
                |> redirect(to: Routes.page_path(conn, :index))

            {:error, _} ->
                conn
                |> put_flash(:info, "Wrong email or password")
                |> render("new.html")
        end
    end

    def delete(conn, _) do
        conn
        |> Blackbook.Session.logout
        |> redirect(to: Routes.page_path(conn, :index))
    end
end