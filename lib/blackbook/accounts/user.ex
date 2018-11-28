defmodule Blackbook.Accounts.User do
    use Ecto.Schema
    import Ecto.Changeset
    alias Blackbook.Accounts.{User,UserType}

    schema "users" do
        field :email, :string
        field :encrypted_password, :string
        field :name, :string
        field :password, :string, virtual: true
        field :password_confirmation, :string, virtual: true
        field :access_key, :string, virtual: true
        belongs_to :user_type, UserType
        
        timestamps()
    end

    @doc false
    def changeset(%User{} = user, attrs) do
        user
        |> cast(attrs, [:name, :email, :password, :password_confirmation])
        |> validate_required([:name, :email, :password, :password_confirmation])
        |> unique_constraint(:email)
        |> validate_format(:email, ~r/@/)
        |> validate_length(:password, min: 5)
        |> validate_confirmation(:password)
        |> put_change(:encrypted_password, hashed_password(attrs["password"]))
    end

    defp hashed_password(password) do
        case password do
            nil -> ""
            _ -> Comeonin.Pbkdf2.hashpwsalt(password)
        end
    end
end