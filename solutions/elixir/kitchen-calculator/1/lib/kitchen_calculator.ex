defmodule KitchenCalculator do
  def get_volume({_, numeric_component}) do
    numeric_component
  end

  def to_milliliter({:milliliter, n}), do: {:milliliter, n}
  def to_milliliter({:cup, n}), do: {:milliliter, 240 * n}
  def to_milliliter({:fluid_ounce, n}), do: {:milliliter, 30 * n}
  def to_milliliter({:teaspoon, n}), do: {:milliliter, 5 * n}
  def to_milliliter({:tablespoon, n}), do: {:milliliter, 15 * n}

  def from_milliliter({_, n}, :milliliter), do: {:milliliter, n}
  def from_milliliter({_, n}, :cup), do: {:cup, n / 240}
  def from_milliliter({_, n}, :fluid_ounce), do: {:fluid_ounce, n / 30}
  def from_milliliter({_, n}, :teaspoon), do: {:teaspoon, n / 5}
  def from_milliliter({_, n}, :tablespoon), do: {:tablespoon, n / 15}

  def convert(volume_pair, unit) do
    from_milliliter(to_milliliter(volume_pair), unit)
  end
end
