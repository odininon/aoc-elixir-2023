defmodule Aoc do
  @moduledoc """
  This module is used to house helper functions for AOC days.
  """

  def readFile(fileName) do
    input_folder = __ENV__.file |> Path.dirname()
    "#{input_folder}/input/#{fileName}.txt" |> File.read!() |> String.trim_trailing()
  end

  def tails(str) do
    tails(String.graphemes(str), [])
  end

  def inits(str) do
    tails(String.graphemes(str) |> Enum.reverse(), [])
    |> Enum.reverse()
    |> Enum.map(fn x -> String.reverse(x) end)
  end

  def parseInt(str) do
    case Integer.parse(str) do
      {i, _} -> i
    end
  end

  defp tails([], ls) do
    Enum.reverse(ls)
  end

  defp tails(str, ls) do
    tails(tl(str), [str |> Enum.join() | ls])
  end
end
