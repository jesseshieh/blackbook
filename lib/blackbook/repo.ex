defmodule Blackbook.Repo do
  use Ecto.Repo,
    otp_app: :blackbook,
    adapter: Ecto.Adapters.Postgres
end
