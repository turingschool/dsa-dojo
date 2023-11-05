require 'minitest'
require 'minitest/autorun'
require './lib/queue.rb'

class StackTest < Minitest::Test
  def test_it_enqueues
    queue = Queue.new
    queue.enqueue("A")
    queue.enqueue("B")
    queue.enqueue("C")
    assert_equal(3, queue.count)
  end

  def test_it_dequeues
    queue = Queue.new
    queue.enqueue("A")
    queue.enqueue("B")
    queue.enqueue("C")
    assert_equal("A", queue.dequeue)
    assert_equal("B", queue.dequeue)
    assert_equal("C", queue.dequeue)
  end

end