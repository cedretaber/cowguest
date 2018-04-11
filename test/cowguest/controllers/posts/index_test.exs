defmodule Cowguest.Controllers.Posts.IndexTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Cowguest.Controllers.Posts.Index
  alias Cowguest.Models.Post

  @posts [
    %Post{name: "anyone", text: "hogehoge"},
    %Post{name: "someone", text: "fugafuga"},
    %Post{name: "someone", text: "piyopiyo"},
    %Post{name: "anyone", text: "日本語"}
  ]

  test "正しくポスト一覧を返すこと" do
    ret =
      conn(:get, "/api/test")
      |> put_req_header("content-type", "application/json")
      |> Index.call(nil)

    assert ret.status == 200
    assert ret.resp_body == Poison.encode!(%{"posts" => @posts})
  end
end
