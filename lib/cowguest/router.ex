defmodule Cowguest.Router do
  @moduledoc false

  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/api/text", to: Cowguest.Controllers.Hello

  get "/", do: send_file(conn, 200, "priv/static/html/index.html")
  get "/index.html", do: send_file(conn, 200, "priv/static/html/index.html")

  plug Plug.Static,
    at: "/public",
    from: "priv/static",
    only: ~w(js css)

  match _, do: send_resp(conn, 404, "404 Not Found")
end
