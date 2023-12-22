defmodule Day18Test do
  use ExUnit.Case, async: true
  doctest Day18

  test "verification, part 1", do: assert(Day18.part1_verify() == 39039.0)
  # test "verification, part 2", do: assert(Day18.part2_verify() == "update or delete me")
end
