defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [
    :nickname,
    battery_percentage: 100,
    distance_driven_in_meters: 0
  ]

  @type t :: %__MODULE__{
          nickname: String.t(),
          battery_percentage: integer(),
          distance_driven_in_meters: integer()
        }

  @spec new() :: RemoteControlCar.t()
  @spec new(String.t()) :: RemoteControlCar.t()
  def new(name \\ "none")
  def new(name), do: %__MODULE__{nickname: name}

  @spec display_distance(RemoteControlCar.t()) :: String.t()
  def display_distance(%__MODULE__{distance_driven_in_meters: meters}), do: "#{meters} meters"

  @spec display_battery(RemoteControlCar.t()) :: String.t()
  def display_battery(%__MODULE__{battery_percentage: 0}), do: "Battery empty"
  def display_battery(%__MODULE__{battery_percentage: battery}), do: "Battery at #{battery}%"

  @spec drive(RemoteControlCar.t()) :: RemoteControlCar.t()
  def drive(%__MODULE__{battery_percentage: 0} = remote_car), do: remote_car

  def drive(
        %__MODULE__{battery_percentage: battery, distance_driven_in_meters: distance} = remote_car
      ) do
    %{remote_car | battery_percentage: battery - 1, distance_driven_in_meters: distance + 20}
  end
end
