defmodule LibraryFees do
  @spec datetime_from_string(String.t()) :: NaiveDateTime.t()
  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)

  @spec before_noon?(NaiveDateTime.t()) :: boolean()
  def before_noon?(datetime), do: datetime.hour < 12

  @spec return_date(NaiveDateTime.t()) :: Date.t()
  def return_date(checkout_datetime) do
    days_to_return = if before_noon?(checkout_datetime), do: 28, else: 29

    checkout_datetime
    |> NaiveDateTime.add(days_to_return, :day)
    |> NaiveDateTime.to_date()
  end

  @spec days_late(Date.t(), NaiveDateTime.t()) :: pos_integer()
  def days_late(planned_return_date, actual_return_datetime) do
    case actual_return_datetime
         |> NaiveDateTime.to_date()
         |> Date.diff(planned_return_date) do
      diff when diff > 0 -> diff
      _ -> 0
    end
  end

  @spec monday?(NaiveDateTime.t()) :: boolean()
  def monday?(datetime) do
    week_day =
      datetime
      |> NaiveDateTime.to_date()
      |> Date.day_of_week()

    week_day == 1
  end

  @spec calculate_late_fee(String.t(), String.t(), integer()) :: integer()
  def calculate_late_fee(checkout, return, rate) do
    plan_return_date = checkout |> datetime_from_string() |> return_date()
    real_return_date = datetime_from_string(return)

    days_late = days_late(plan_return_date, real_return_date)

    fee = rate * days_late

    if monday?(real_return_date), do: div(fee, 2), else: fee
  end
end
