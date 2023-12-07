defmodule Day07Test do
  use ExUnit.Case, async: true
  doctest Day07

  test "verification, part 1", do: assert(Day07.part1_verify() == 248_217_452)
  test "verification, part 2", do: assert(Day07.part2_verify() == 245_576_185)
end
