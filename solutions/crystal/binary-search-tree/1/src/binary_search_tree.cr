# Please implement your solution to binary-search-tree in this file
class Node(T)
  @data : T
  @left : Nil | Node(T)
  @right : Nil | Node(T)
  
  def initialize(data : T )
    @data = data
    @left = nil
    @right = nil
  end
  def value
    @data
  end
  def left
    @left
  end
  def right
    @right
  end
  def insert(data)
    if data <= @data
      left = @left
      if left.nil?
        @left = Node.new data
      else
        left.insert data
      end
    else
      right = @right
      if right.nil?
        @right = Node.new data
      else
        right.insert data
      end
    end
  end
  def sort
    result = [] of T
    left = @left
    unless left.nil?
      result += left.sort
    end
    result += [@data]
    right = @right
    unless right.nil?
      result += right.sort
    end
    result
  end
end