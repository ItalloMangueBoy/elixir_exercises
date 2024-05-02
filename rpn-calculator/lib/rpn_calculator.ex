defmodule RPNCalculator do
  @type operation :: (list() -> term())

  @spec calculate!(list(), operation()) :: term() | no_return()
  def calculate!(stack, operation), do: operation.(stack)

  @spec calculate(list(), operation()) :: :error | {:ok, term()}
  def calculate(stack, operation) do
    try do
      {:ok, calculate!(stack, operation)}
    rescue
      _e in _ -> :error
    end
  end

  @spec calculate_verbose(list(), operation()) :: {:error, term()} | {:ok, term()}
  def calculate_verbose(stack, operation) do
    try do
      {:ok, calculate!(stack, operation)}
    rescue
      e in _ -> {:error, e.message}
    end
  end
end
