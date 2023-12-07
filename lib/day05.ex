defmodule Day05 do
  def input() do
    Aoc.readFile("day05")
  end

  def part1(input) do
    parts = input |> String.split("\n\n")

    seeds =
      parts
      |> hd
      |> String.split(":")
      |> tl()
      |> Enum.flat_map(fn str -> str |> String.trim() |> String.split(" ") end)
      |> Enum.map(fn str -> String.to_integer(str) end)

    mappings =
      parts
      |> tl()
      |> Enum.reduce(seeds, fn elem, acc ->
        map = parse_mapping_string(elem, acc)
        Enum.map(acc, fn seed -> location(seed, map) end)
      end)

    Enum.min(mappings)
  end

  def parse_input(input) do
    input
  end

  def parse_mapping_string(mapping_string, seeds) do
    mappings = mapping_string |> String.split("\n") |> tl()

    parse_mappings(mappings, seeds, Map.new())
  end

  def parse_mappings([], _, map), do: map

  def parse_mappings([mapping | mappings], seeds, map) do
    parse_mappings(mappings, seeds, parse_map(map, seeds, mapping))
  end

  def parse_map(map, seeds, key) do
    [destination, source, range] =
      key |> String.split(" ") |> Enum.map(fn x -> String.to_integer(x) end)

    updates =
      Enum.map(seeds, fn seed ->
        case spot_in_range(seed, source, range) do
          nil -> nil
          v -> {source + v, destination + v}
        end
      end)
      |> Enum.filter(fn spot -> spot != nil end)

    update_map(updates, map)
  end

  def spot_in_range(seed, source, range) do
    if seed >= source and seed <= source + range do
      seed - source
    else
      nil
    end
  end

  def update_map([], map), do: map

  def update_map([{source, destination} | updates], map) do
    update_map(updates, Map.put(map, source, destination))
  end

  def location(key, []), do: key

  def location(key, [mapping | mappings]) do
    location(location(key, mapping), mappings)
  end

  def location(key, map) do
    case Map.fetch(map, key) do
      {:ok, v} -> v
      _ -> key
    end
  end

  def part1_verify, do: input() |> parse_input() |> part1()
end
