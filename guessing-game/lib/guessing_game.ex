defmodule GuessingGame do
  @spec compare(integer) :: bitstring()
  @spec compare(integer, integer | :no_guess) :: bitstring()

  @doc """
  Compare a guess to an secret number end send and choose a respost for each case:

  "Correct": When the guess matches the secret number
  "So close": When the guess is one more or one less than the secret number
  "Too high": When the guess is greater than the secret number
  "Too low": When the guess is less than the secret number
  "Make a guess": When a guess isn't made
  """

  def compare(secret_number, guess \\ :no_guess)

  def compare(secret_number, guess)
      when not is_integer(secret_number) or not is_integer(guess),
      do: "Make a guess"

  def compare(secret_number, guess) when secret_number == guess,
    do: "Correct"
  def compare(secret_number, guess) when secret_number in [guess - 1, guess + 1],
    do: "So close"

  def compare(secret_number, guess) when secret_number < guess,
    do: "Too high"

  def compare(secret_number, guess) when secret_number > guess,
    do: "Too low"
end
