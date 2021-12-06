require 'byebug'

class Fish
  def execute
    fishes = read_input

    256.times do
      puts fishes.length
      fishes.split('').select { |f| f == '0' }.length.times { fishes += '9' }
      fishes = fishes.split('').map { |f| f.to_i - 1 == -1 ? 6 : f.to_i - 1 }.join
    end

    puts "There are #{fishes.length} fish"
  end

  def read_input
    File.readlines('input2.txt')[0].chomp.split(',').join
  end
end

Fish.new.execute
