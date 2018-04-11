defmodule Cowguest.Router.Generic do
  defmacro __using__(opts) do
    quote location: :keep do
      use Plug.Router, unquote(opts)
      plug Plug.Logger
      plug :match
      plug :dispatch
    end
  end
end

defmodule Cowguest.Router do
  @moduledoc false

  use Cowguest.Router.Generic
  use Plug.Debugger, otp_app: :cowguest

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
    use Cowguest.Router.Generic

    get "/text", to: Cowguest.Controllers.Hello
    get "/posts", to: Cowguest.Controllers.Posts.Index
    post "/posts", to: Cowguest.Controllers.Posts.Post

    match _, do: send_resp(conn, 404, "No API.")
  end

  forward "/api", to: APIRoute

  get _, do: send_file(conn, 200, "priv/static/html/index.html")
end
