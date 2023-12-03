defmodule Day03Test do
  use ExUnit.Case, async: true
  doctest Day03

  test "verification, part 1", do: assert(Day03.part1_verify() == 530_849)
  test "verification, part 2", do: assert(Day03.part2_verify() == 84_900_879)
end
