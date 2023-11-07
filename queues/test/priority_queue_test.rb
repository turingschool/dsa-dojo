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

  def test_pq_total_count
    pq = PriorityQueue.new(3)
    plane = Plane.new(name: "UA1", expected_departure: 510, expected_landing: 615)
    plane2 = Plane.new(name: "UA2", expected_departure: 510, expected_landing: 615)
    plane3 = Plane.new(name: "UA3", expected_departure: 510, expected_landing: 615)
    pq.enqueue(2, plane2)
    pq.enqueue(2, plane3)
    pq.enqueue(1, plane)
    assert_equal 3, pq.total_count
  end

  def test_pq_queue_wait
    pq = PriorityQueue.new(3)
    plane = Plane.new(name: "UA1", expected_departure: 510, expected_landing: 615)
    plane2 = Plane.new(name: "UA2", expected_departure: 510, expected_landing: 615)
    plane3 = Plane.new(name: "UA3", expected_departure: 510, expected_landing: 615)
    pq.enqueue(2, plane2)
    pq.enqueue(2, plane3)
    pq.enqueue(1, plane)
    actual = pq.queue_wait(plane3)
    assert_equal 2, actual
  end

  def test_pq_queue_wait_complex
    pq = PriorityQueue.new(3)
    planes = [*1..10].map { |n| Plane.new(name: "UA#{n}", expected_departure: 510, expected_landing: 615) }
    planes.each_with_index do |plane, i|
      lane = (i % 3) + 1
      pq.enqueue(lane, plane)
    end

    actual = pq.queue_wait(planes[7])
    puts
    digest = planes.each_with_index.map { |plane, i| { name: plane.name, wait: pq.queue_wait(plane), lane: (i % 3) + 1 } }
    expected = [
      { name: "UA1", wait: 0, lane: 1 },
      { name: "UA2", wait: 4, lane: 2 },
      { name: "UA3", wait: 7, lane: 3 },
      { name: "UA4", wait: 1, lane: 1 },
      { name: "UA5", wait: 5, lane: 2 },
      { name: "UA6", wait: 8, lane: 3 },
      { name: "UA7", wait: 2, lane: 1 },
      { name: "UA8", wait: 6, lane: 2 },
      { name: "UA9", wait: 9, lane: 3 },
      { name: "UA10", wait: 3, lane: 1 },
    ]

    assert_equal expected, digest
  end
end
