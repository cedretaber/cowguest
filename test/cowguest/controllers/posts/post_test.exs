defmodule Cowguest.Controllers.Posts.PostTest do
  use ExUnit.Case, async: false
  use Plug.Test

  alias Cowguest.Controllers.Posts
  alias Cowguest.Models.Post

  setup_all do
    on_exit fn ->
      Redix.command(:redix, ["flushdb"])
    end
  end

  setup do
    Redix.command(:redix, ["flushdb"])
    {:ok, %{}}
  end

  test "正しくポストを投稿できること" do
    post = %Post{id: 0, name: "test name", text: "test text"}

    ret =
      conn(:post, "/api/test", %{name: post.name, text: post.text})
      |> put_req_header("content-type", "application/json")
      |> Posts.Post.call(nil)

    assert ret.status == 200
    assert ret.resp_body == Poison.encode!(%{"id" => 0})

    assert Redix.command(:redix, ["hget", "post-0", "name"]) == {:ok, post.name}
    assert Redix.command(:redix, ["hget", "post-0", "text"]) == {:ok, post.text}

    post = %Post{id: 0, name: "test name 2", text: "test text 2"}

    ret =
      conn(:post, "/api/test", %{name: post.name, text: post.text})
      |> put_req_header("content-type", "application/json")
      |> Posts.Post.call(nil)

    assert ret.status == 200
    assert ret.resp_body == Poison.encode!(%{"id" => 1})

    assert Redix.command(:redix, ["hget", "post-1", "name"]) == {:ok, post.name}
    assert Redix.command(:redix, ["hget", "post-1", "text"]) == {:ok, post.text}
  end
end
