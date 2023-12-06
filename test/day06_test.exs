defmodule Day06Test do
  use ExUnit.Case, async: true
  doctest Day06

  test "verification, part 1", do: assert(Day06.part1_verify() == 1_413_720)
  test "verification, part 2", do: assert(Day06.part2_verify() == 30_565_288)
end
