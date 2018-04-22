defmodule Cowguest.Controllers.Posts.Index do
  @moduledoc false

  use Cowguest.Controller

  alias Cowguest.Repo.Posts

  def init(opts), do: opts

  def call(conn, _opts) do
    posts =
      case to_json(%{posts: Posts.all()}) do
        {:ok, posts} -> posts
        _ -> []
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, posts)
  end
end
