defmodule Day04 do
  def input() do
    Aoc.readFile("day04")
  end

  def parse_input(input) do
    input |> String.split("\n") |> Enum.map(&parse_card/1)
  end

  def part1(input) do
    input
    |> Enum.map(&points_for_card/1)
    |> Enum.sum()
  end

  def part2(input) do
    matches =
      input
      |> Enum.map(fn %{"number" => number, "matching_numbers" => matching_numbers} ->
        {
          number,
          %{"card" => number, "matching_numbers" => length(matching_numbers), "amount" => 1}
        }
      end)
      |> Map.new()

    ticket_amount(matches, [])
    |> Enum.map(fn %{"amount" => amount} -> amount end)
    |> Enum.sum()
  end

  def parse_card(card) do
    [card_details, rest] = card |> String.split(": ")
    [winning_string, our_number_string] = rest |> String.trim() |> String.split(" | ")
    winning_numbers = winning_string |> format_number_string_to_list()
    our_numbers = our_number_string |> format_number_string_to_list()

    "Card " <> number = card_details

    %{
      "number" => String.to_integer(number |> String.trim()),
      "winning_numbers" => winning_numbers,
      "our_numbers" => our_numbers,
      "matching_numbers" => find_matching_numbers(winning_numbers, our_numbers, [])
    }
  end

  def points_for_card(%{"matching_numbers" => matching_numbers}) do
    points_for_matching(matching_numbers)
  end

  defp ticket_amount(matches, parsed_matches) do
    cards = Map.keys(matches) |> Enum.sort()
    process_cards(cards, matches, parsed_matches)
  end

  defp process_cards([], _, parsed_matches), do: parsed_matches

  defp process_cards([card_number | card_numbers], matches, parsed_matches) do
    %{"matching_numbers" => matching_numbers, "amount" => amount} =
      card = Map.get(matches, card_number)

    if matching_numbers == 0 do
      process_cards(card_numbers, matches, [card | parsed_matches])
    else
      cards_to_increment = (card_number + 1)..(matching_numbers + card_number)

      process_cards(
        card_numbers,
        increment_matches(Enum.to_list(cards_to_increment), amount, matches),
        [
          card | parsed_matches
        ]
      )
    end
  end

  defp increment_matches([], _, matches), do: matches

  defp increment_matches([card_number | card_numbers], amount_increment, matches) do
    updated_matches =
      Map.update!(matches, card_number, fn match ->
        %{"amount" => amount} = match
        %{match | "amount" => amount + amount_increment}
      end)

    increment_matches(card_numbers, amount_increment, updated_matches)
  end

  defp format_number_string_to_list(number_string) do
    number_string
    |> String.split(" ", trim: true)
    |> Enum.map(fn str -> str end)
  end

  defp find_matching_numbers([], _, matching_numbers), do: matching_numbers

  defp find_matching_numbers([winning_number | winning_numbers], our_numbers, matching_numbers) do
    case Enum.find(our_numbers, fn num -> winning_number == num end) do
      nil ->
        find_matching_numbers(winning_numbers, our_numbers, matching_numbers)

      number ->
        find_matching_numbers(winning_numbers, List.delete(our_numbers, number), [
          number | matching_numbers
        ])
    end
  end

  defp points_for_matching([]), do: 0

  defp points_for_matching([_ | matching]) do
    points_for_matching(matching, 1)
  end

  defp points_for_matching([], points), do: points

  defp points_for_matching([_ | matching], points) do
    points_for_matching(matching, points * 2)
  end

  def part1_verify, do: input() |> parse_input() |> part1()
  def part2_verify, do: input() |> parse_input() |> part2()
end
