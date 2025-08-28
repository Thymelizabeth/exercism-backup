defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(%{data: tree_data, left: left, right: right}, data) do
    cond do
      data <= tree_data -> cond do
        left == nil -> %{data: tree_data, left: new(data), right: right}
        true -> %{data: tree_data, left: insert(left, data), right: right}
      end
      data > tree_data -> cond do
        right == nil -> %{data: tree_data, left: left, right: new(data)}
        true -> %{data: tree_data, left: left, right: insert(right, data)}
      end
    end
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(%{data: data, left: left, right: right}) do
    List.flatten([
      if(left != nil, do: in_order(left), else: []),
      [data],
      if(right != nil, do: in_order(right), else: [])
    ])
  end
end
