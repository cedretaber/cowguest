defmodule Cowguest.Controllers.HelloTest do
  use ExUnit.Case, async: true
  doctest Cowguest.Controllers.Hello

  use Plug.Test

  alias Cowguest.Controllers.Hello

  test "正しくウェブページを返すこと" do
    ret =
      conn(:get, "/api/test")
      |> put_req_header("content-type", "application/json")
      |> Hello.call({})

    assert ret.status == 200
    assert ret.resp_body == "Hello, world!"
  end
end
