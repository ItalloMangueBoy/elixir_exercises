defmodule BoutiqueInventory do
  @type item :: %{
          name: String.t(),
          price: integer(),
          quantity_by_size: map()
        }

  @type inventory :: [item()]

  @spec sort_by_price(inventory()) :: inventory()
  def sort_by_price(inventory), do: Enum.sort_by(inventory, & &1.price, :asc)

  @spec with_missing_price(inventory()) :: inventory()
  def with_missing_price(inventory), do: Enum.filter(inventory, &(!&1.price))

  @spec update_names(inventory, String.t(), String.t()) :: inventory
  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      new_name = String.replace(item.name, old_word, new_word)
      %{item | name: new_name}
    end)
  end

  @spec increase_quantity(item(), integer()) :: item()
  def increase_quantity(item, count) do
    incremented_size_list =
      Map.new(item.quantity_by_size, fn {size, quantity} -> {size, quantity + count} end)

    %{item | quantity_by_size: incremented_size_list}
  end

  @spec total_quantity(item()) :: integer()
  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, &(elem(&1, 1) + &2))
  end
end
