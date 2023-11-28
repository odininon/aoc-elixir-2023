defmodule Mix.Tasks.Day do
  use Mix.Task
  import Mix.Generator, only: [copy_template: 3]

  def run([day]) do
    formatted_day = String.pad_leading(day, 2, "0")

    file_path = Path.join([File.cwd!(), "lib", "day#{formatted_day}.ex"])
    copy_template("priv/templates/day.ex", file_path, day: formatted_day)

    test_path = Path.join([File.cwd!(), "test", "day#{formatted_day}_test.exs"])
    copy_template("priv/templates/day_test.ex", test_path, day: formatted_day)

    input_path = Path.join([File.cwd!(), "lib", "input", "day#{formatted_day}.txt"])
    copy_template("priv/templates/day.txt", input_path, day: formatted_day)
  end

  def run([]) do
    "Please provide the day number to generate a template for, eg. `mix day 7` for day 7"
    |> Mix.Shell.IO.error()
  end
end
