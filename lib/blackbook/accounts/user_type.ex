defmodule Blackbook.Accounts.UserType do
    use Ecto.Schema
    import Ecto.Changeset
    alias Blackbook.Accounts.{UserType,User}

    schema "user_types" do
        field :actions, {:array, :string}
        field :type, :string
        has_many :user, User

        timestamps()
    end

    @doc false
    def changeset(%UserType{} = user_type, attrs) do
        user_type
        |> cast(attrs, [:type, :actions])
        |> validate_required([:type, :actions])
        |> unique_constraint(:type)
    end
end