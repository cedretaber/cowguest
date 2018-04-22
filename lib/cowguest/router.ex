defmodule Cowguest.Router do
  @moduledoc false

  use Plug.Router
  use Plug.Debugger, otp_app: :cowguest

  plug Plug.Logger
  plug :match
  plug :dispatch

  defmodule StaticRouter do
    use Plug.Builder
    plug Plug.Logger

    plug Plug.Static,
      at: "/",
      from: :cowguest,
      only: ~w(js css images favicon.ico robots.txt)
  end

  forward "/public", to: StaticRouter

  defmodule APIRoute do
    use Plug.Router

    plug Plug.Parsers,
      parsers: [:json],
      pass: ["application/json"],
      json_decoder: Poison

    plug :match
    plug :dispatch

    get "/posts", to: Cowguest.Controllers.Posts.Index
    post "/posts", to: Cowguest.Controllers.Posts.Post

    match _, do: send_resp(conn, 404, "No API.")
  end

  forward "/api", to: APIRoute

  get _, do: send_file(conn, 200, "priv/static/html/index.html")
end
