class Queue
  attr_reader :count

  def initialize
    @head = Node.new(:head)
    @tail = Node.new(:tail, @head)
    @count = 0
  end

  def enqueue(x)
    @count += 1
    node = Node.new(x)
    node.right = @tail
    left = @tail.left
    left.right = node
    @tail.left = node
  end

  def dequeue
    @count -= 1
    popped = @head.right
    @head.right = popped.right
    popped.val
  end

  def peek
    @head.right.val
  end

  def last
    @tail.left.val
  end

  def empty
    @count == 0
  end
end

class Node
  attr_accessor :val, :left, :right

  def initialize(val, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end
