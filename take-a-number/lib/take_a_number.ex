defmodule TakeANumber do
  @doc """
  will start the procces
  """
  @spec start() :: pid()
  def start() do
    spawn(fn -> loop(0) end)
  end

  @doc """
  recive process messages and send responses
  """
  @spec loop(integer()) :: no_return()
  def loop(state) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, state) |> loop()

      {:take_a_number, sender_pid} ->
        send(sender_pid, state + 1) |> loop()

      :stop ->
        nil

      _ ->
        loop(state)
    end
  end
end
