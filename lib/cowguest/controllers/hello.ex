defmodule Cowguest.Controllers.Hello do
  @moduledoc false

  use Cowguest.Controller

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, "Hello, world!")
  end
end
