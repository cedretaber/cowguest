defmodule Cowguest.Controllers.Posts.Index do
  @moduledoc false

  use Cowguest.Controller

  alias Cowguest.Models.Post

  def init(opts), do: opts

  @posts [
    %Post{name: "anyone", text: "hogehoge"},
    %Post{name: "someone", text: "fugafuga"},
    %Post{name: "someone", text: "piyopiyo"},
    %Post{name: "anyone", text: "日本語"}
  ]

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.Encoder.encode(%{posts: @posts}, []))
  end
end
