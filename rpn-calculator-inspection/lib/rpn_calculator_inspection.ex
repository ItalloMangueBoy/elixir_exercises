defmodule RPNCalculatorInspection do
  @type input :: String.t()
  @type calculator :: (input() -> term())
  @type reliability_check :: %{pid: pid(), input: input()}
  @type reliability_checks_map :: %{optional(input()) => :ok | :error | :timeout}

  @spec start_reliability_check(calculator(), input()) :: %{input: input(), pid: pid()}
  def start_reliability_check(calculator, input) do
    pid = spawn_link(fn -> calculator.(input) end)

    %{pid: pid, input: input}
  end

  @spec await_reliability_check_result(reliability_check(), reliability_checks_map()) ::
          reliability_checks_map()
  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _reason} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  @spec reliability_check(calculator(), [input()]) :: reliability_checks_map()
  def reliability_check(calculator, inputs) do
    original_flag = Process.flag(:trap_exit, true)

    inputs
    |> Enum.map(&start_reliability_check(calculator, &1))
    |> Enum.reduce(%{}, &await_reliability_check_result/2)
    |> tap(fn _ -> Process.flag(:trap_exit, original_flag) end)
  end

  @spec correctness_check(calculator(), [input()]) :: [number()]
  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(&Task.async(fn -> calculator.(&1) end))
    |> Task.await_many(100)
  end
end
