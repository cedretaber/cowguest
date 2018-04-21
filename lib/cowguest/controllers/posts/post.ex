defmodule Cowguest.Controllers.Posts.Post do
  @moduledoc false

  use Cowguest.Controller

  def init(opts), do: opts

  def call(conn, _opts) do
    case to_json(%{id: 1}) do
      {:ok, body} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, body)

      _ ->
        conn
        |> send_resp(500, "500 Internal Server Error")
    end
  end
end
