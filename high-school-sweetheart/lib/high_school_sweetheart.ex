defmodule HighSchoolSweetheart do
  @doc """
  Recive an string and returns this first letter
  """
  @spec first_letter(binary()) :: nil | binary()
  def first_letter(name), do: String.trim(name) |> String.first()

  @doc """
  Recive an name and returns his initial
  """
  @spec initial(binary()) :: nonempty_binary()
  def initial(name), do: first_letter(name) |> String.upcase() |> Kernel.<>(".")

  @doc """
  recive an full name and returns his initials
  """
  @spec initials(binary()) :: nonempty_binary()
  def initials(full_name) do
    names = String.trim(full_name) |> String.split(" ")

    first_initial = List.first(names) |> initial()
    last_initial = List.last(names) |> initial()

    "#{first_initial} #{last_initial}"
  end

  @doc """
  recive 2 names an returns an cute messsage
  """
  @spec pair(binary(), binary()) :: <<_::64, _::_*8>>
  def pair(full_name1, full_name2) do


    name_1_initial = initials(full_name1)
    name_2_initial = initials(full_name2)

    """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{name_1_initial}  +  #{name_2_initial}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """
  end
end
