defmodule Username do
  @spec sanitize(charlist()) :: charlist()
  def sanitize([]), do: []

  def sanitize([head | tail]) do
    sanitized =
      case head do
        alpha when alpha in ?a..?z -> [alpha]
        ?ä -> ~c"ae"
        ?ö -> ~c"oe"
        ?ü -> ~c"ue"
        ?ß -> ~c"ss"
        ?_ -> ~c"_"
        _ -> []
      end

    sanitized ++ sanitize(tail)
  end
end
