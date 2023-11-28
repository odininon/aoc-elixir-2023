defmodule Day<%= @day %> do

  def input() do
    Aoc.readFile("day<%= @day %>")
  end

  def part1(input) do
    input
  end

  # def part2(input) do
  #   input
  # end

  def parse_input(input) do
    input
  end

  def part1_verify, do: input() |> parse_input() |> part1()
  #def part2_verify, do: input() |> parse_input() |> part2()
end