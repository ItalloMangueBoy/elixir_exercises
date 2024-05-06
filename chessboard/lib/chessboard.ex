defmodule Chessboard do
  @spec rank_range() :: Range.t()
  def rank_range, do: 1..8

  @spec file_range() :: Range.t()
  def file_range, do: ?A..?H

  @spec ranks() :: list()
  def ranks, do: Enum.to_list(rank_range())

  @spec files() :: list()
  def files, do: Enum.map(file_range(), &<<&1>>)
end
