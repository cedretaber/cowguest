defmodule Cowguest.Repo.Posts do
  @moduledoc false

  alias Cowguest.Repo
  alias Cowguest.Models.Post

  def all() do
    case keys() do
      {:ok, keys} ->
        keys
        |> Enum.map(&find_by_key/1)
        |> Enum.reject(&is_nil/1)
        |> Enum.sort_by(fn %Post{id: id} -> -id end)

      _ ->
        []
    end
  end

  def find_by_key(key) do
    id = key_to_num(key)

    with {:ok, text} <- Repo.get(key, :text),
         {:ok, name} <- Repo.get(key, :name) do
      %Post{id: id, text: text, name: name}
    else
      _ -> nil
    end
  end

  def insert(%{text: text, name: name}) do
    case next_number() do
      {:ok, n} ->
        key = "post-#{n}"
        Repo.put(key, text: text, name: name)
        {:ok, n}

      _ ->
        {:error, "Failed to create new Post."}
    end
  end

  defp next_number() do
    with {:ok, keys} <- keys(),
         [last_num | _] <-
           keys
           |> Enum.map(&key_to_num/1)
           |> Enum.sort_by(&(-&1)) do
      {:ok, last_num + 1}
    else
      [] ->
        {:ok, 0}

      _ ->
        {:error, "Faild to find last number."}
    end
  end

  defp keys() do
    Repo.keys("post-*")
  end

  defp key_to_num(key) do
    case Regex.run(~r/post-(\d+)/, key) do
      [_, ns] -> String.to_integer(ns)
      _ -> 0
    end
  end
end
