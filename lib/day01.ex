defmodule Day01 do
  @part_one_words %{
    "1" => "1",
    "2" => "2",
    "3" => "3",
    "4" => "4",
    "5" => "5",
    "6" => "6",
    "7" => "7",
    "8" => "8",
    "9" => "9"
  }

  @part_two_words Map.merge(@part_one_words, %{
                    "one" => "1",
                    "two" => "2",
                    "three" => "3",
                    "four" => "4",
                    "five" => "5",
                    "six" => "6",
                    "seven" => "7",
                    "eight" => "8",
                    "nine" => "9"
                  })

  defp input() do
    Aoc.readFile("day01")
  end

  defp part1(input) do
    input
    |> Enum.map(&value(&1, @part_one_words))
    |> Enum.reduce(0, fn i, acc -> acc + parseInt(i) end)
  end

  defp part2(input) do
    input
    |> Enum.map(&value(&1, @part_two_words))
    |> Enum.reduce(0, fn i, acc -> acc + parseInt(i) end)
  end

  defp parse_input(input) do
    input |> String.split("\n")
  end

  defp value(word, word_list) do
    first_number = Aoc.tails(word) |> first(word_list)
    last_number = Aoc.inits(word) |> Enum.reverse() |> last(word_list)
    first_number <> last_number
  end

  defp first(word, word_list) do
    find_element(word, word_list, &String.starts_with?/2)
  end

  defp last(word, word_list) do
    find_element(word, word_list, &String.ends_with?/2)
  end

  defp find_element([word | words], word_list, fun) do
    case Enum.filter(Map.keys(word_list), fn a -> fun.(word, a) end) do
      [] -> find_element(words, word_list, fun)
      [v | _] -> Map.get(word_list, v)
    end
  end

  def parseInt(str) do
    case Integer.parse(str) do
      {i, _} -> i
    end
  end

  def part1_verify, do: input() |> parse_input() |> part1()
  def part2_verify, do: input() |> parse_input() |> part2()
end
