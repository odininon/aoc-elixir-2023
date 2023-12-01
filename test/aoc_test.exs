defmodule AocTest do
  use ExUnit.Case, async: true
  doctest Aoc

  test "tails" do
    assert(Aoc.tails("two1nine") == ["two1nine", "wo1nine", "o1nine", "1nine", "nine", "ine", "ne", "e"])
  end
end
