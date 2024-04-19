defmodule RPG.CharacterSheet do
  @type char_sheet :: %{class: binary(), level: integer(), name: binary()}

  @spec welcome() :: :ok
  def welcome(), do: IO.puts("Welcome! Let's fill out your character sheet together.")

  @spec ask_name() :: binary()
  def ask_name() do
    "What is your character's name?\n"
    |> IO.gets()
    |> String.trim()
  end

  @spec ask_class() :: binary()
  def ask_class() do
    "What is your character's class?\n"
    |> IO.gets()
    |> String.trim()
  end

  @spec ask_level() :: integer()
  def ask_level() do
    "What is your character's level?\n"
    |> IO.gets()
    |> String.trim()
    |> String.to_integer()
  end

  @spec run() :: char_sheet()
  def run() do
    welcome()

    %{
      name: ask_name(),
      class: ask_class(),
      level: ask_level()
    }
    |> IO.inspect(label: "Your character")
  end
end
