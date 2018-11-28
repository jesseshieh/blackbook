defmodule Blackbook.Session do
    alias Blackbook.Accounts.User
    alias Blackbook.Repo
    alias Blackbook.Auth.Guardian
    alias Comeonin.Pbkdf2
    import Plug.Conn
    import Ecto.Query
    
    def authenticate_user(email, given_password) do
        query = Ecto.Query.from(u in User, where: u.email == ^email)

        Repo.one(query)
        |> check_password(given_password)
    end

    defp check_password(nil, _), do: {:error, "Incorrect email(case sensitive) or password"}

    defp check_password(user, given_password) do
        case Pbkdf2.checkpw(given_password, user.encrypted_password) do
            true -> {:ok, user}
            false -> {:error, "Incorrect email(case sensitive) or password"}
        end
    end

    def login(conn, user) do
        IO.puts("++++")
        IO.inspect(user)
        IO.puts("++++")
        conn
        |> Guardian.Plug.sign_in(user)
    end

    def logout(conn) do
        conn
        |> Guardian.Plug.sign_out()
    end
end