defmodule Day01Test do
  use ExUnit.Case, async: true
  doctest Day01

  test "verification, part 1", do: assert(Day01.part1_verify() == 55447)
  test "verification, part 2", do: assert(Day01.part2_verify() == 54706)

  test "replacement of word strings to numbers", do: assert(Day01.tails("two1nine") == ["two1nine", "wo1nine", "o1nine", "1nine", "nine", "ine", "ne", "e"])
end
