# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :blackbook,
  ecto_repos: [Blackbook.Repo]

# Configures the endpoint
config :blackbook, BlackbookWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "u5Z/lGl+H+5T8/QtsYPdxYgwQ5wPBPiBHsELbqiEs2sMalWKTAsNQW2u7M11IQID",
  render_errors: [view: BlackbookWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Blackbook.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures Guardian
config :blackbook, Blackbook.Auth.Guardian,
  issuer: "blackbook",
  secret_key: "ig/gZgvAv8cYdoNjeVSqEvL3LUa/mK6p4NrSng0enDRjIktxbQtDKj9dag0cUCWX"

config :blackbook, Blackbook.Auth.AuthAccessPipeline,
  module: Blackbook.Auth.Guardian,
  error_handler: Blackbook.Auth.AuthErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
