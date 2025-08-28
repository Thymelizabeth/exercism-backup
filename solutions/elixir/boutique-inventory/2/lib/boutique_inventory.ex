defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort(inventory, &((&1).price <= (&2).price))
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, fn item -> item.price == nil end)
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item -> elem(Map.get_and_update(item, :name, fn name -> {name, String.replace(name, old_word, new_word)} end), 1) end)
  end

  def increase_quantity(item, count) do
    Map.update(item, :quantity_by_size, Map.new(), fn sizes -> Map.new(Enum.map(sizes, fn {k, v} -> {k, v + count} end)) end)
  end

  def total_quantity(item) do
    Enum.reduce(Map.values(Map.get(item, :quantity_by_size)), 0, &(&1 + &2))
  end
end
