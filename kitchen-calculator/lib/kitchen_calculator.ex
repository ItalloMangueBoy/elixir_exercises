defmodule KitchenCalculator do
  @type(unit :: :milliliter, :cup, :fluid_ounce, :teaspoon, :tablespoon)
  @type volume :: number
  @type volume_pair :: {unit, volume}

  @doc """
  From an volume_pair returns only volume measurement
  """
  @spec get_volume(volume_pair) :: volume
  def get_volume({_, volume}), do: volume

  @doc """
  Pick an volume pair from any volume measurement and convert this to an milliliter volume pair
  """
  @spec to_milliliter(volume_pair) :: {:milliliter, volume}
  def to_milliliter({:milliliter, _} = volume_pair), do: volume_pair
  def to_milliliter({:fluid_ounce, volume}), do: {:milliliter, volume * 30}
  def to_milliliter({:tablespoon, volume}), do: {:milliliter, volume * 15}
  def to_milliliter({:teaspoon, volume}), do: {:milliliter, volume * 5}
  def to_milliliter({:cup, volume}), do: {:milliliter, volume * 240}

  @doc """
  Pick an milliliter volume pair and convert this to an volume pair from chosen unit measurement
  """
  @spec from_milliliter({:milliliter, volume}, unit) :: volume_pair
  def from_milliliter({:milliliter, _} = volume_pair, :milliliter), do: volume_pair
  def from_milliliter({:milliliter, volume}, :fluid_ounce = unit), do: {unit, volume / 30}
  def from_milliliter({:milliliter, volume}, :tablespoon = unit), do: {unit, volume / 15}
  def from_milliliter({:milliliter, volume}, :teaspoon = unit), do: {unit, volume / 5}
  def from_milliliter({:milliliter, volume}, :cup = unit), do: {unit, volume / 240}

  @doc """
  pick an volume pair ond convert this to an volume pair from chose unit measurement
  """
  @spec convert(volume_pair, unit) :: volume_pair
  def convert(volume_pair, unit), do: volume_pair |> to_milliliter() |> from_milliliter(unit)
end
