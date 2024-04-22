defmodule BasketballWebsite do
  @spec extract_from_path(map(), String.t()) :: any()
  def extract_from_path(data, path) do
    path_list = String.split(path, ".")
    do_extract_from_path(data, path_list)
  end

  defp do_extract_from_path(data, []), do: data

  defp do_extract_from_path(data, [head | tail]),
    do: do_extract_from_path(data[head], tail)

  @spec get_in_path(map(), String.t()) :: any()
  def get_in_path(data, path), do: get_in(data, String.split(path, "."))
end
