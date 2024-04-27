defmodule BoutiqueSuggestions do
  @type item :: %{
          item_name: String.t(),
          base_color: String.t(),
          price: float()
        }

  @type item_combination :: {item(), item()}

  @spec get_combinations([item()], [item()]) :: [item_combination()]
  @spec get_combinations([item()], [item()], list()) :: [item_combination()]
  def get_combinations(tops, bottoms, options \\ [])

  def get_combinations(tops, bottoms, options) do
    max_price = Keyword.get(options, :maximum_price, 100.0)

    for top <- tops,
        bottom <- bottoms,
        top.base_color != bottom.base_color,
        top.price + bottom.price <= max_price do
      {top, bottom}
    end
  end
end
