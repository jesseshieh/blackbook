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

  scope "/", BlackbookWeb do
    pipe_through :browser

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete

    get "/", PageController, :index

    resources "/user_types", UserTypeController
    resources "/access_keys", AccessKeyController
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlackbookWeb do
  #   pipe_through :api
  # end
end
