defmodule BirdCount do
  @type visits :: [integer()]

  @doc """
  Recive an visits list and returns the today visit numbers or nil if list is empity
  """
  @spec today(visits()) :: nil | integer()
  def today([]), do: nil
  def today(visits), do: List.first(visits)

  @doc """
  Recive an visits list and increment the today visits count in one, if list is empity return [1]
  """
  @spec increment_day_count(visits()) :: visits()
  def increment_day_count([]), do: [1]

  def increment_day_count(visits),
    do: List.update_at(visits, 0, &(&1 + 1))

  @doc """
  Recive an visits list and return true if has days whithout visits or false is all days has visits
  """
  @spec has_day_without_birds?(visits()) :: boolean()
  def has_day_without_birds?(visits), do: Enum.member?(visits, 0)

  @doc """
  Recive an visits list and returns the total number of visits
  """
  @spec total(visits()) :: number()
  def total(visits), do: Enum.sum(visits)

  @doc """
  Recive an visits list and return an list of visits whithout days who vistis < 5
  """
  @spec busy_days(visits()) :: non_neg_integer()
  def busy_days(visits), do: Enum.count(visits, fn visit -> visit >= 5 end)
end
