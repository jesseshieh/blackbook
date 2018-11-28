defmodule BlackbookWeb.SessionController do
    use BlackbookWeb, :controller

    alias Blackbook.Accounts
    alias Blackbook.Session
    alias Blackbook.Accounts.User

    def index(conn, _params) do
        changeset = Accounts.change_user(%User{})
        user = Guardian.Plug.current_resource(conn)
        message = if user != nil do
            "logged in"
        else
            "Please log in"
        end
        conn
          |> put_flash(:info, message)
          |> render("new.html", changeset: changeset, action: Routes.session_path(conn, :login), user: user)
    end

    def login(conn, %{"session" => %{"email" => email, "password" => password}}) do
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

    def logout(conn, _) do
        conn
        |> Blackbook.Session.logout
        |> redirect(to: Routes.session_path(conn, :index))
    end
end