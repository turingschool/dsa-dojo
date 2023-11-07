require "minitest"
require "minitest/autorun"
require "./lib/priority_queue.rb"

class PriorityQueueTest < Minitest::Test
  def test_pq_enqueue_and_next
    pq = PriorityQueue.new(3)
    plane = Plane.new(name: "UA1", expected_departure: 510, expected_landing: 615)
    plane2 = Plane.new(name: "UA2", expected_departure: 510, expected_landing: 615)
    plane3 = Plane.new(name: "UA3", expected_departure: 510, expected_landing: 615)
    pq.enqueue(2, plane2)
    pq.enqueue(2, plane3)
    pq.enqueue(1, plane)
    next_plane = pq.next
    assert_equal plane, next_plane
    next_plane = pq.next
    assert_equal plane2, next_plane
  end

  def test_pq_enqueue_and_next
    pq = PriorityQueue.new(3)
    plane = Plane.new(name: "UA1", expected_departure: 510, expected_landing: 615)
    plane2 = Plane.new(name: "UA2", expected_departure: 510, expected_landing: 615)
    plane3 = Plane.new(name: "UA3", expected_departure: 510, expected_landing: 615)
    pq.enqueue(2, plane2)
    pq.enqueue(2, plane3)
    pq.enqueue(1, plane)
    next_plane = pq.peek
    assert_equal plane, next_plane
    next_plane = pq.peek
    assert_equal plane, next_plane
  end

  def test_pq_status
    pq = PriorityQueue.new(3)
    plane = Plane.new(name: "UA1", expected_departure: 510, expected_landing: 615)
    plane2 = Plane.new(name: "UA2", expected_departure: 510, expected_landing: 615)
    plane3 = Plane.new(name: "UA3", expected_departure: 510, expected_landing: 615)
    pq.enqueue(2, plane2)
    pq.enqueue(2, plane3)
    pq.enqueue(1, plane)
    status = pq.status
    expected = {
      1 => 1,
      2 => 2,
      3 => 0,
    }
    assert_equal expected, status
  end
end
