defmodule Cowguest.Controllers.Posts.IndexTest do
  use ExUnit.Case, async: false
  use Plug.Test

  alias Cowguest.Controllers.Posts.Index
  alias Cowguest.Models.Post

  @posts [
    %Post{id: 3, name: "anyone", text: "hogehoge"},
    %Post{id: 2, name: "someone", text: "fugafuga"},
    %Post{id: 1, name: "someone", text: "piyopiyo"},
    %Post{id: 0, name: "anyone", text: "日本語"}
  ]

  setup_all do
    on_exit fn ->
      Redix.command(:redix, ["flushdb"])
    end
  end

  setup do
    Redix.command(:redix, ["flushdb"])
    {:ok, %{}}
  end

  test "正しくポスト一覧を返すこと" do
    for %{id: id, name: name, text: text} <- @posts do
      Redix.command(:redix, ["hset", "post-#{id}", "name", name, "text", text])
    end

    ret =
      conn(:get, "/api/test")
      |> put_req_header("content-type", "application/json")
      |> Index.call(nil)

    assert ret.status == 200
    assert ret.resp_body == Poison.encode!(%{"posts" => @posts})
  end
end
