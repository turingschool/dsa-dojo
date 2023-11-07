class Queue
  attr_reader :count

  def initialize
    @head = Node.new(:head)
    @tail = Node.new(:tail, @head)
    @count = 0
  end

  def add(node)
    @count += 1
    node.right = @tail
    left = @tail.left
    left.right = node
    @tail.left = node
  end

  def enqueue(x)
    node = Node.new(x)
    add(node)
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

  def find(node)
    current = @head
    while current != nil && current.val != node
      current = current.right
    end
    current
  end

  def to_s
    current = @head.right
    str = ""
    while current != nil && current != @tail
      str += "#{current.val.to_s} "
      current = current.right
    end
    str
  end

  def queue_wait(node)
    current = @head.right
    count = 0
    while current != nil && current.val != node
      current = current.right
      count += 1
    end
    count
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
