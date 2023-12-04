defmodule Day04Test do
  use ExUnit.Case, async: true
  doctest Day04

  test "verification, part 1", do: assert(Day04.part1_verify() == 23673)
  test "verification, part 2", do: assert(Day04.part2_verify() == 12_263_631)

  test "card 1 points" do
    assert(
      "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"
      |> Day04.parse_card()
      |> Day04.points_for_card() == 8
    )
  end
end
