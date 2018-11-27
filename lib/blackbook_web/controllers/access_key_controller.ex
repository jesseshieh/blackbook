defmodule BlackbookWeb.AccessKeyController do
    use BlackbookWeb, :controller

    alias Blackbook.Accounts
    alias Blackbook.Accounts.AccessKey

    def index(conn, _params) do
        access_keys = Accounts.list_access_keys()
        render(conn, "index.html", access_keys: access_keys)
    end

    def new(conn, _params) do
        user_types = Accounts.list_user_types()
        changeset = Accounts.change_access_key(%AccessKey{})
        render(conn, "new.html", changeset: changeset, user_types: user_types)
    end

    def create(conn, %{"access_key" => access_key_params}) do
        {user_type_id, _} = access_key_params["type"] |> Integer.parse
        key = UUID.uuid4()
        access_key_params = Map.put(access_key_params, "access_key", key)

        case Accounts.create_access_key(access_key_params, user_type_id) do
            {:ok, access_key} ->
                conn
                |> put_flash(:info, "Access key created successfully")
                |> redirect(to: Routes.access_key_path(conn, :show, access_key))

            {:error, %Ecto.Changeset{} = changeset} ->
                render(conn, "new.html", changeset: changeset)
        end
    end

    def show(conn, %{"id" => id}) do
        access_key = Accounts.get_access_key!(id)
        render(conn, "show.html", access_key: access_key)
    end

    def delete(conn, %{"id" => id}) do
        access_key = Accounts.get_access_key!(id)
        {:ok, _access_key} = Accounts.delete_access_key(access_key)

        conn
        |> put_flash(:info, "Access key deleted successfully.")
        |> redirect(to: Routes.access_key_path(conn, :index))
    end
end