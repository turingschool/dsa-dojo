require "./lib/queue.rb"

class PriorityQueue
  def initialize(lanes = 5)
    @lanes = {}
    (1..lanes).each { |i| @lanes[i] = Queue.new }
  end

  def enqueue(lane, plane)
    @lanes[lane].enqueue(plane)
  end

  def next
    @lanes.find { |lane, queue| !queue.empty }[1].dequeue
  end

  def peek
    @lanes.find { |lane, queue| !queue.empty }[1].peek
  end

  def status
    @lanes.map { |lane, queue| [lane, queue.count] }.to_h
  end

  def total_count
    @lanes.values.map(&:count).sum
  end

  def queue_wait(plane)
    ahead = @lanes.slice_after { |lane, queue| queue.find(plane) }.first.reverse
    lane, *rest = ahead.map(&:last)
    within_lane_count = lane.queue_wait(plane)
    priority_ahead_count = rest.map(&:count).sum

    within_lane_count + priority_ahead_count
  end
end

class Plane
  attr_reader :name, :expected_departure, :expected_landing

  def initialize(name:, expected_departure:, expected_landing:)
    @name = name
    @expected_departure = expected_departure
    @expected_landing = expected_landing
  end

  def to_s
    @name
  end
end
