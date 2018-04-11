defmodule Cowguest.Controllers.Posts.Post do
  @moduledoc false

  use Cowguest.Controller

  alias Cowguest.Models.Post

  def init(opts), do: opts

  def call(conn, _opts),
    do:
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Poison.encode!(%{id: 1}))
end
