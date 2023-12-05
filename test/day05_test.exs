defmodule Day05Test do
  use ExUnit.Case, async: true
  doctest Day05

  test "verification, part 1", do: assert(Day05.part1_verify() == 600_279_879)
  # test "verification, part 2", do: assert(Day05.part2_verify() == "update or delete me")
end
