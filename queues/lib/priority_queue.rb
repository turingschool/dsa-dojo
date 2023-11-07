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
end

class Plane
  attr_reader :name, :expected_departure, :expected_landing

  def initialize(name:, expected_departure:, expected_landing:)
    @name = name
    @expected_departure = expected_departure
    @expected_landing = expected_landing
  end
end
