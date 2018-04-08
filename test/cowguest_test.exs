defmodule CowguestTest do
  use ExUnit.Case
  doctest Cowguest

  test "greets the world" do
    assert Cowguest.hello() == :world
  end
end
