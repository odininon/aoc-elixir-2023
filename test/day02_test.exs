defmodule Day02Test do
  use ExUnit.Case, async: true
  doctest Day02

  test "verification, part 1", do: assert(Day02.part1_verify() == 2377)
  test "verification, part 2", do: assert(Day02.part2_verify() == 71220)
end
