defmodule Day02 do
  def input() do
    Aoc.readFile("day02")
  end

  def parse_input(input) do
    input |> String.split("\n")
  end

  def part1(input) do
    possible_games(input, %{"red" => 12, "green" => 13, "blue" => 14}, 0)
  end

  def part2(input) do
    Enum.map(Enum.map(input, &parse_game(&1)), fn game ->
      Enum.map(["red", "green", "blue"], fn color ->
        Enum.map(Map.get(game, "pulls"), &Map.get(&1, color, 0)) |> Enum.max()
      end)
      |> Enum.reduce(1, fn e, a -> a * e end)
    end)
    |> Enum.sum()
  end

  def possible_games([], _, count) do
    count
  end

  def possible_games([game | games], combo, count) do
    parsed_game = parse_game(game)

    case Enum.any?(Map.get(parsed_game, "pulls"), &illegal_pull?(&1, combo)) do
      true -> possible_games(games, combo, count)
      false -> possible_games(games, combo, count + Map.get(parsed_game, "number"))
    end
  end

  def illegal_pull?(pull, combo) do
    Enum.any?(Map.keys(combo), &(Map.get(pull, &1, 0) > Map.get(combo, &1)))
  end

  def parse_game(game) do
    ["Game " <> number, rest] = String.split(game, ": ")
    pulls = String.split(rest, "; ")

    %{
      "number" => String.to_integer(number),
      "pulls" => Enum.map(pulls, &parse_pull(&1))
    }
  end

  def parse_pull(pull) do
    pull
    |> String.split(", ")
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(fn [v, k] -> {k, String.to_integer(v)} end)
    |> Map.new()
  end

  def part1_verify, do: input() |> parse_input() |> part1()
  def part2_verify, do: input() |> parse_input() |> part2()
end
