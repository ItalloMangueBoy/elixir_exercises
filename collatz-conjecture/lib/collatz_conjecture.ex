defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when is_integer(input) and input > 0, do: do_calc({input, 0})

  @spec do_calc({number(), non_neg_integer()}) :: non_neg_integer()
  def do_calc({x, tries}) do
    cond do
      x == 1 -> tries
      trunc(x) |> rem(2) == 0 -> do_calc({x / 2, tries + 1})
      true -> do_calc({x * 3 + 1, tries + 1})
    end
  end
end
