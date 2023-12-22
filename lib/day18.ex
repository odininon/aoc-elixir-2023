defmodule Day18 do
  def input() do
    Aoc.readFile("day18")
  end

  def part1(input) do
    map =
      input
      |> String.split("\n")
      |> Enum.map(fn line ->
        [direction, amount, _rest] = String.split(line, " ")
        [direction, amount |> String.to_integer()]
      end)
      |> dig_out()

    map = (map ++ [{0, 0}]) |> Enum.chunk_every(2, 1, :discard) |> Enum.reverse()
    show_laced_area = map |> shoe_lace()
    show_laced_area - length(map) / 2 + length(map) + 1
  end

  # def part2(input) do
  #   input
  # end

  def shoe_lace(pairs) do
    shoe_lace(pairs, 0)
  end

  def shoe_lace([], area), do: area / 2

  def shoe_lace([pair | pairs], area) do
    [{x1, y1}, {x2, y2}] = pair
    shoe_lace(pairs, area + x1 * y2 - y1 * x2)
  end

  def parse_input(input) do
    input
  end

  def dig_out(instructions) do
    dig_out(instructions, {0, 0}, [])
  end

  def dig_out([], _point, points), do: points

  def dig_out([instruction | instructions], point, points) do
    new_points = handle_instruction(instruction, point, [])
    dig_out(instructions, hd(new_points), [new_points | points] |> List.flatten())
  end

  def handle_instruction([_direction, 0], _point, points), do: points

  def handle_instruction([direction, amount], {x, y}, points) do
    new_point =
      case direction do
        "R" -> {x + 1, y}
        "L" -> {x - 1, y}
        "U" -> {x, y + 1}
        "D" -> {x, y - 1}
      end

    handle_instruction([direction, amount - 1], new_point, [new_point | points])
  end

  def part1_verify, do: input() |> parse_input() |> part1()
  # def part2_verify, do: input() |> parse_input() |> part2()
end
