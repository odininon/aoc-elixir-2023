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

  def input() do
    Aoc.readFile("day01")
  end

  def part1(input) do
    input
    |> Enum.map(&value(&1, @part_one_words))
    |> Enum.reduce(0, fn i, acc -> acc + parseInt(i) end)
  end

  def part2(input) do
    input
    |> Enum.map(&value(&1, @part_two_words))
    |> Enum.reduce(0, fn i, acc -> acc + parseInt(i) end)
  end

  def parse_input(input) do
    input |> String.split("\n")
  end

  def value(str, word_list) do
    firstNumber(str, word_list) <> lastNumber(str, word_list)
  end

  def firstNumber(word, word_list) do
    first(tails(word), word_list)
  end

  def first([word | words], word_list) do
    case Enum.filter(Map.keys(word_list), fn a -> String.starts_with?(word, a) end) do
      [] -> first(words, word_list)
      [v | _] -> Map.get(word_list, v)
    end
  end

  def last([word | words], word_list) do
    case Enum.filter(Map.keys(word_list), fn a -> String.ends_with?(word, a) end) do
      [] -> last(words, word_list)
      [v | _] -> Map.get(word_list, v)
    end
  end

  def lastNumber(word, word_list) do
    last(inits(word) |> Enum.reverse(), word_list)
  end

  def parseInt(str) do
    case Integer.parse(str) do
      {i, _} -> i
    end
  end

  def inits(str) do
    tails(String.graphemes(str) |> Enum.reverse(), [])
    |> Enum.reverse()
    |> Enum.map(fn x -> String.reverse(x) end)
  end

  def tails(str) do
    tails(String.graphemes(str), [])
  end

  def tails([], ls) do
    Enum.reverse(ls)
  end

  def tails(str, ls) do
    tails(tl(str), [str |> Enum.join() | ls])
  end

  def part1_verify, do: input() |> parse_input() |> part1()
  def part2_verify, do: input() |> parse_input() |> part2()
end
