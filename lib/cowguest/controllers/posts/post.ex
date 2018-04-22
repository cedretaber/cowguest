defmodule Cowguest.Controllers.Posts.Post do
  @moduledoc false

  use Cowguest.Controller

  alias Cowguest.Repo.Posts
  alias Cowguest.Models.Post

  def init(opts), do: opts

  def call(%{params: %{"name" => name, "text" => text}} = conn, _opts) do
    with {:ok, id} <- Posts.insert(%Post{id: 0, name: name, text: text}),
         {:ok, body} <- to_json(%{id: id}) do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, body)
    else
      _ ->
        conn
        |> send_resp(500, "Internal Server Error")
    end
  end

  def call(conn, _opts) do
    conn
    |> send_resp(500, "Internal Server Error")
  end
end
