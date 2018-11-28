defmodule BlackbookWeb.Router do
  use BlackbookWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authaccess do
    plug Blackbook.Plugs.RequireAuth
  end

  pipeline :auth do
    plug Blackbook.Auth.AuthAccessPipeline
  end

  scope "/", BlackbookWeb do
    pipe_through :browser

    get "/", SessionController, :index
    post "/login", SessionController, :login
    delete "/logout", SessionController, :logout
  end

  scope "/", BlackbookWeb do
    pipe_through [:browser, :auth]

    get "/page", PageController, :index

    resources "/user_types", UserTypeController
    resources "/access_keys", AccessKeyController
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlackbookWeb do
  #   pipe_through :api
  # end
end
