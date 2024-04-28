# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]

  @type t :: %__MODULE__{plot_id: integer(), registered_to: String.t()}
end

defmodule CommunityGarden do
  @spec start() :: Agent.on_start()
  @spec start(keyword()) :: Agent.on_start()
  def start(opts \\ []), do: Agent.start(fn -> %{plots: [], next_id: 1} end, opts)

  @spec list_registrations(pid()) :: [Plot.t()]
  def list_registrations(pid), do: Agent.get(pid, & &1.plots)

  @spec register(pid(), String.t()) :: Plot.t()
  def register(pid, register_to) do
    Agent.get_and_update(
      pid,
      fn state ->
        new_plot = %Plot{plot_id: state.next_id, registered_to: register_to}
        new_state = %{next_id: state.next_id + 1, plots: [new_plot | state.plots]}

        {new_plot, new_state}
      end
    )
  end

  @spec release(pid(), integer()) :: :ok
  def release(pid, plot_id) do
    relesed_plots =
      for plot <- list_registrations(pid),
          plot.plot_id != plot_id,
          do: plot

    Agent.update(pid, &%{&1 | plots: relesed_plots})
  end

  @spec get_registration(pid(), integer()) :: Plot.t() | {:not_found, String.t()}
  def get_registration(pid, plot_id) do
    pid
    |> list_registrations()
    |> Enum.find({:not_found, "plot is unregistered"}, &(&1.plot_id == plot_id))
  end
end
