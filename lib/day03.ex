defmodule Day03 do
  @dirs [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]]

  def input() do
    Aoc.readFile("day03")
  end

  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line -> String.split(line, "") |> Enum.filter(fn col -> col != "" end) end)
  end

  def part1(input) do
    input |> valid_part_numbers() |> Enum.sum()
  end

  def part2(input) do
    input |> valid_gear_ratios() |> Enum.sum()
  end

  def valid_part_numbers(grid) do
    valid_part_numbers(grid, [])
  end

  def valid_part_numbers(grid, part_numbers) do
    find_valid_parts(grid, %{"x" => 0, "y" => 0}, part_numbers)
  end

  def find_valid_parts(_, nil, part_numbers) do
    part_numbers
  end

  def find_valid_parts(grid, %{"x" => x, "y" => y} = grid_point, part_numbers) do
    point = Enum.at(grid, y) |> Enum.at(x)

    case Integer.parse(point) do
      {_, _} ->
        find_valid_parts(grid, next_col(grid, grid_point), part_numbers)

      _ ->
        if point == "." or point == "" do
          find_valid_parts(grid, next_col(grid, grid_point), part_numbers)
        else
          surrounding_parts = find_surrounding_parts(grid, grid_point)

          find_valid_parts(
            grid,
            next_col(grid, grid_point),
            List.flatten([
              surrounding_parts | part_numbers
            ])
          )
        end
    end
  end

  def valid_gear_ratios(grid) do
    valid_gear_ratios(grid, [])
  end

  def valid_gear_ratios(grid, gear_ratios) do
    find_valid_gears(grid, %{"x" => 0, "y" => 0}, gear_ratios)
  end

  def find_valid_gears(_, nil, gear_ratios), do: gear_ratios

  def find_valid_gears(grid, %{"x" => x, "y" => y} = grid_point, gear_ratios) do
    point = Enum.at(grid, y) |> Enum.at(x)

    if point == "*" do
      surrounding_parts = find_surrounding_parts(grid, grid_point)

      if length(surrounding_parts) == 2 do
        find_valid_gears(grid, next_col(grid, grid_point), [
          Enum.reduce(surrounding_parts, 1, fn e, a -> a * e end) | gear_ratios
        ])
      else
        find_valid_gears(grid, next_col(grid, grid_point), gear_ratios)
      end
    else
      find_valid_gears(grid, next_col(grid, grid_point), gear_ratios)
    end
  end

  def find_surrounding_parts(grid, grid_point) do
    Enum.map(@dirs, &check_direction(grid, grid_point, &1))
    |> Enum.filter(&(&1 != nil))
    |> Aoc.uniq()
    |> Enum.map(fn {_, n} -> String.to_integer(n) end)
  end

  def check_direction(grid, %{"x" => x, "y" => y}, [dx, dy]) do
    max_rows = length(grid)
    max_cols = Enum.at(grid, 0) |> length()

    x2 = x + dx
    y2 = y + dy

    if x2 < 0 or x2 >= max_cols or y2 < 0 or y2 >= max_rows do
      nil
    else
      case whole_number(grid, %{"x" => x2, "y" => y2}) do
        {_, ""} -> nil
        v -> v
      end
    end
  end

  def next_col(grid, %{"x" => x, "y" => y}) do
    max_rows = length(grid)
    max_cols = Enum.at(grid, 0) |> length()

    if x + 1 >= max_cols do
      if y + 1 >= max_rows do
        nil
      else
        %{"x" => 0, "y" => y + 1}
      end
    else
      %{"x" => x + 1, "y" => y}
    end
  end

  def whole_number(grid, grid_point) do
    whole_number(grid, grid_point, true, true)
  end

  def whole_number(grid, %{"x" => x, "y" => y} = grid_point, check_left, check_right) do
    max_cols = Enum.at(grid, 0) |> length()
    point = Enum.at(grid, y) |> Enum.at(x)

    if x < 0 or x >= max_cols do
      {nil, ""}
    else
      case Integer.parse(point) do
        {_, _} ->
          {_, left_part} =
            case check_left do
              false -> {nil, ""}
              true -> whole_number(grid, %{"x" => x - 1, "y" => y}, true, false)
            end

          {gp, right_part} =
            case check_right do
              false -> {grid_point, ""}
              true -> whole_number(grid, %{"x" => x + 1, "y" => y}, false, true)
            end

          {gp, left_part <> point <> right_part}

        _ ->
          {%{"x" => x - 1, "y" => y}, ""}
      end
    end
  end

  def part1_verify, do: input() |> parse_input() |> part1()
  def part2_verify, do: input() |> parse_input() |> part2()
end
