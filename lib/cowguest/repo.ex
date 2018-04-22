defmodule Cowguest.Repo do
  @moduledoc false

  def keys(pattern \\ "*") do
    Redix.command(:redix, ["keys", pattern])
  end

  def get(key, hkey) when is_binary(key) and is_binary(hkey) do
    Redix.command(:redix, ["hget", key, hkey])
  end

  def get(key, hkey) when is_binary(key), do: get(key, to_string(hkey))

  def get(key, hkey), do: get(to_string(key), hkey)

  def put(key, kvs) when is_binary(key) do
    cmds =
      kvs
      |> Enum.reduce([key, "hset"], fn
        {k, v}, list when is_atom(k) -> [v, Atom.to_string(k) | list]
        {k, v}, list when is_binary(k) -> [v, k | list]
        e, list when is_binary(e) -> [e | list]
        e, list -> [to_string(e) | list]
      end)
      |> Enum.reverse()

    Redix.command(:redix, cmds)
  end

  def put(key, kvs), do: put(to_string(key), kvs)
end
