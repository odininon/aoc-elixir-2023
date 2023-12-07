defmodule Day06 do
  def input() do
    Aoc.readFile("day06")
  end

  def parse_input(input) do
    [time, distance] = input |> String.split("\n")
    [_, times] = time |> String.split(":")
    [_, distances] = distance |> String.split(":")
    {times, distances}
  end

  def parse_numbers(line) do
    line
    |> String.trim()
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def score_race({time, distance}) do
    q = (time ** 2 - 4 * distance) ** 0.5
    floor((time + q) * 0.5) - ceil((time - q) * 0.5) + 1
  end

  def part1({times, distances}) do
    times = parse_numbers(times)
    distances = parse_numbers(distances)

    Enum.zip(times, distances)
    |> Enum.map(&score_race/1)
    |> Enum.product()
  end

  def part2({times, distances}) do
    time = String.replace(times, " ", "") |> String.to_integer()
    distance = String.replace(distances, " ", "") |> String.to_integer()
    score_race({time, distance})
  end

  def part1_verify, do: input() |> parse_input() |> part1()
  def part2_verify, do: input() |> parse_input() |> part2()
end
