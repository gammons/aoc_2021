require 'byebug'

class Fish
  def execute
    fishes = read_input

    buckets = []
    9.times do |x|
      buckets[x] = fishes.select { |f| f == x }.length
    end

    256.times do
      zero_count = buckets[0]
      8.times do |x|
        buckets[x] = buckets[x + 1]
      end
      buckets[6] += zero_count
      buckets[8] = zero_count
    end

    puts "There are #{buckets.inject(0) { |sum, n| sum + n }} fish"
  end

  def read_input
    File.readlines('input.txt')[0].chomp.split(',').map(&:to_i)
  end
end

Fish.new.execute
