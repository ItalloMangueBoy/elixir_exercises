defmodule LogParser do
  @spec valid_line?(String.t()) :: boolean()
  def valid_line?(line), do: line =~ ~r"^\[DEBUG]|\[INFO]|\[WARNING]|\[ERROR]"

  @spec split_line(String.t()) :: [String.t()]
  def split_line(line), do: Regex.split(~r"<[~*=-]*>", line)

  @spec remove_artifacts(String.t()) :: String.t()
  def remove_artifacts(line), do: Regex.replace(~r"end-of-line[0-9]+"i, line, "")

  @spec tag_with_user_name(String.t()) :: String.t()
  def tag_with_user_name(line) do
    case Regex.run(~r"User\s+(\S+)", line) do
      [_, user] -> "[USER] #{user} " <> line
      _ -> line
    end
  end
end
