defmodule Cowguest.Router do
  @moduledoc false

  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/", to: Cowguest.Controllers.Hello

  match _, do: send_resp(conn, 404, "404 Not Found")
end
