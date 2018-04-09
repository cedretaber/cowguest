defmodule Cowguest.Controllers.HelloTest do
  use ExUnit.Case, async: true
  doctest Cowguest.Controllers.Hello

  use Plug.Test

  alias Cowguest.Controllers.Hello

  test "正しくウェブページを返すこと" do
    ret =
      conn(:get, "/")
      |> put_req_header("content-type", "application/json")
      |> Hello.call({})

    assert ret.status == 200
    assert Regex.match?(~r/Cowboy Hello!!/, ret.resp_body)
  end
end
