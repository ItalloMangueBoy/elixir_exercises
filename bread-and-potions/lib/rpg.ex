defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0

    @type t :: %__MODULE__{health: integer(), mana: integer()}
  end

  defmodule LoafOfBread do
    defstruct []

    @type t :: %__MODULE__{}
  end

  defmodule ManaPotion do
    defstruct strength: 10

    @type t :: %__MODULE__{strength: integer()}
  end

  defmodule Poison do
    defstruct []

    @type t :: %__MODULE__{}
  end

  defmodule EmptyBottle do
    defstruct []

    @type t :: %__MODULE__{}
  end

  defprotocol Edible do
    def eat(item, char)
  end

  defimpl Edible, for: LoafOfBread do
    @spec eat(LoafOfBread.t(), Character.t()) :: {nil, Character.t()}
    def eat(%LoafOfBread{}, char) do
      {nil, %{char | health: char.health + 5}}
    end
  end

  defimpl Edible, for: ManaPotion do
    @spec eat(ManaPotion.t(), Character.t()) :: {EmptyBottle.t(), Character.t()}
    def eat(%ManaPotion{strength: strength}, char) do
      {%EmptyBottle{}, %{char | mana: char.mana + strength}}
    end
  end

  defimpl Edible, for: Poison do
    @spec eat(Poison.t(), Character.t()) :: {EmptyBottle.t(), Character.t()}
    def eat(%Poison{}, char) do
      {%EmptyBottle{}, %{char | health: 0}}
    end
  end
end
