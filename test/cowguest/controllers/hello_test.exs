defmodule Cowguest.Controllers.HelloTest do
  use ExUnit.Case, async: true
  doctest Cowguest.Controllers.Hello

  use Plug.Test

  alias Cowguest.Controllers.Hello

  test "正しくテキストを返すこと" do
    ret =
      conn(:get, "/api/posts/")
      |> put_req_header("content-type", "application/json")
      |> Hello.call(nil)

    assert ret.status == 200
    assert ret.resp_body == "Hello, world!"
  end
end
