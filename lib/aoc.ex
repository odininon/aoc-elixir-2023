defmodule Aoc do
  @moduledoc """
  This module is used to house helper functions for AOC days.
  """

  def readFile(fileName) do
    input_folder = __ENV__.file |> Path.dirname()
    "#{input_folder}/input/#{fileName}.txt" |> File.read!() |> String.trim_trailing()
  end
end
