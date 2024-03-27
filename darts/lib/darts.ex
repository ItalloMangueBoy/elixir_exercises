defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate an square root
  """
  @spec sqrt(number) :: float
  def sqrt(x) when is_integer(x), do: sqrt(x * 1.0)
  def sqrt(x), do: Float.pow(x, 0.5)

  @doc """
  Calculate the distance of a point from center
  """
  @spec calcule_distance_from_center(position) :: float
  def calcule_distance_from_center({x, y}), do: sqrt(x * x + y * y)

  @doc """
  Calculate the score of a single dart
  """
  @spec score(position) :: integer
  def score(point) do
    distance_from_center = calcule_distance_from_center(point)
    cond do
      distance_from_center <= 1 -> 10
      distance_from_center <= 5 -> 5
      distance_from_center <= 10 -> 1
      true -> 0
    end
  end

end
