defmodule HighScore do
  @type name :: binary()
  @type score :: integer()
  @type scores :: %{optional(name()) => score()}

  @doc """
  Create an score map
  """
  @spec new() :: %{}
  def new(), do: %{}

  @doc """
  take an  player name and his score an add this to given score list
  """
  @spec add_player(scores(), name()) :: scores()
  @spec add_player(scores(), name(), score()) :: scores()
  def add_player(scores, name, score \\ 0)
  def add_player(scores, name, score), do: Map.put(scores, name, score)

  @doc """
  take an player name and remove his score from the given score list
  """
  @spec remove_player(scores(), name()) :: scores()
  def remove_player(scores, name), do: Map.drop(scores, [name])

  @doc """
  take an player name and reset his score in the given score list
  """
  @spec reset_score(scores(), name()) :: scores()
  def reset_score(scores, name), do: Map.put(scores, name, 0)

  @doc """
  take an player name and his new score and sum this whis his actual score in the given score list
  """
  @spec update_score(scores(), name(), score()) :: scores()
  def update_score(scores, name, score), do: Map.update(scores, name, score, &(&1 + score))

  @doc """
  take an score list and returns an player list
  """
  @spec get_players(scores()) :: [name()]
  def get_players(scores), do: Map.keys(scores)
end
