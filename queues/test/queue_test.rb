require "minitest"
require "minitest/autorun"
require "./lib/queue.rb"

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

  def test_it_peeks
    queue = Queue.new
    queue.enqueue("A")
    queue.enqueue("B")
    queue.enqueue("C")
    assert_equal("A", queue.peek)
    queue.dequeue
    assert_equal("B", queue.peek)
  end

  def test_it_gets_last
    queue = Queue.new
    queue.enqueue("A")
    queue.enqueue("B")
    queue.enqueue("C")
    assert_equal("C", queue.last)
    queue.dequeue
    assert_equal("C", queue.last)
  end

  def test_it_gets_empty
    queue = Queue.new
    assert_equal(true, queue.empty)
    queue.enqueue("A")
    assert_equal(false, queue.empty)
    queue.dequeue
    assert_equal(true, queue.empty)
  end
end
