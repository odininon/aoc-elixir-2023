defmodule Day07 do
  def input() do
    Aoc.readFile("day07")
  end

  def parse_input(input) do
    input |> String.split("\n") |> Enum.map(&String.split(&1, " "))
  end

  def part1(input) do
    solve(input, false)
  end

  def part2(input) do
    solve(input, true)
  end

  def solve(input, joker) do
    input
    |> Enum.map(&parse(&1, joker: joker))
    |> Enum.sort(fn %{"points" => a}, %{"points" => b} -> a <= b end)
    |> Enum.chunk_by(fn %{"points" => points} -> points end)
    |> Enum.map(&break_ties/1)
    |> List.flatten()
    |> Enum.map(fn %{"bid" => bid} -> bid end)
    |> Enum.with_index(&(&1 * (&2 + 1)))
    |> Enum.sum()
  end

  def parse([cards, bid], options \\ []) do
    joker = Keyword.get(options, :joker, false)

    cards = cards |> String.split("", trim: true)

    %{
      "points" => cards |> count_instances_of_cards(joker),
      "cards" => cards |> Enum.map(&numerate(&1, joker)),
      "bid" => String.to_integer(bid)
    }
  end

  def count_instances_of_cards(cards, true) do
    values = count_instances(cards, Map.new())
    number_of_jokers = Map.get(values, "J", 0)

    values
    |> Map.delete("J")
    |> Map.values()
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> List.update_at(0, &(&1 + number_of_jokers))
    |> score()
  end

  def count_instances_of_cards(cards, false) do
    count_instances(cards, Map.new())
    |> Map.values()
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> score()
  end

  def count_instances([], map), do: map

  def count_instances([card | cards], map) do
    count_instances(cards, Map.update(map, card, 1, &(&1 + 1)))
  end

  def break_ties(hands) do
    Enum.sort(hands, fn %{"cards" => a}, %{"cards" => b} -> sort_tie(a, b) end)
  end

  def sort_tie([a | a_cards], [b | b_cards]) do
    cond do
      a < b -> true
      a > b -> false
      a == b -> sort_tie(a_cards, b_cards)
    end
  end

  def score(score) do
    case score do
      [1, 1] -> 1
      [2, 1] -> 2
      [2, 2] -> 3
      [3, 1] -> 4
      [3, 2] -> 5
      [4, _] -> 6
      [5] -> 7
      [] -> 7
    end
  end

  def numerate(kicker, joker) do
    case Integer.parse(kicker) do
      {v, _} ->
        v

      _ ->
        case kicker do
          "T" ->
            10

          "J" ->
            case joker do
              true -> 1
              false -> 11
            end

          "Q" ->
            12

          "K" ->
            13

          "A" ->
            14
        end
    end
  end

  def part1_verify, do: input() |> parse_input() |> part1()
  def part2_verify, do: input() |> parse_input() |> part2()
end
