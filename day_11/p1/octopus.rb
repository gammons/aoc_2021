require 'byebug'
class Grid
  def execute
    @grid = read_input
    @flash_count = 0

    # print_grid
    # increment

    100.times do
      # print_grid
      increment
      flash
    end
    puts @flash_count
  end

  def increment
    @grid.each_with_index { |line, y| line.each_with_index { |num, x| @grid[y][x] = num + 1 } }
  end

  def flash
    new_grid = @grid.dup
    flashed = []

    flashing_count = @grid.inject(0) { |sum, line| sum + line.inject(0) { |s, n| n > 9 ? s + 1 : s } }

    while flashed.length < flashing_count
      new_grid.each_with_index do |line, y|
        line.each_with_index do |_num, x|
          next if new_grid[y][x] < 10 || flashed.include?([x, y])

          flashed << [x, y]
          @flash_count += 1

          if y.positive?
            new_grid[y - 1][x - 1] += 1 if x.positive?
            new_grid[y - 1][x + 0] += 1
            new_grid[y - 1][x + 1] += 1 if x + 1 < line.length
          end

          new_grid[y][x - 1] += 1 if x.positive?
          new_grid[y][x + 1] += 1 if x + 1 < line.length

          next unless y + 1 < new_grid.length

          new_grid[y + 1][x - 1] += 1 if x.positive?
          new_grid[y + 1][x + 0] += 1
          new_grid[y + 1][x + 1] += 1 if x + 1 < line.length
        end
      end
      flashing_count = @grid.inject(0) { |sum, line| sum + line.inject(0) { |s, n| n > 9 ? s + 1 : s } }
    end
    new_grid.each_with_index { |line, y| line.each_with_index { |_num, x| new_grid[y][x] = 0 if new_grid[y][x] > 9 } }

    @grid = new_grid
  end

  def print_grid
    @grid.each do |line|
      puts line.join('')
    end
    puts ''
  end

  def read_input
    File.read('input.txt').split("\n").map { |line| line.split('').map(&:to_i) }
  end
end

Grid.new.execute
