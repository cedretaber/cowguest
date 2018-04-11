defmodule Cowguest.Controllers.Posts.PostTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Cowguest.Controllers.Posts

  test "正しくポストを投稿できること" do
    ret =
      conn(:post, "/api/test")
      |> put_req_header("content-type", "application/json")
      |> Posts.Post.call(nil)

    assert ret.status == 200
    assert ret.resp_body == Poison.encode!(%{"id" => 1})
  end
end
