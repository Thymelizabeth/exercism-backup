=begin
Write your code for the 'Binary Search Tree' exercise in this file. Make the tests in
`binary_search_tree_test.rb` pass.


To get started with TDD, see the `README.md` file in your
`ruby/binary-search-tree` directory.
=end
class Bst
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
  def data
    return @data
  end
  def left
    return @left
  end
  def right
    return @right
  end
  def insert(data)
    if data <= @data then
      if @left == nil then
        @left = Bst.new data
      else
        @left.insert data
      end
    else
      if @right == nil then
        @right = Bst.new data
      else
        @right.insert data
      end
    end
  end
  def each(&block)
    return enum_for(__method__) if block.nil?
    if @left != nil then
      @left.each do |value|
        block.call value
      end
    end
    block.call @data
    if @right != nil then
      @right.each do |value|
        block.call value
      end
    end
  end
end