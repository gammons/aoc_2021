class HeightMap
  def execute
    @map = read_input
    low_points = []

    @map.each_with_index do |row, y|
      row.each_with_index do |num, x|
        sides = []
        sides << row[x - 1] if x.positive?
        sides << row[x + 1] unless row[x + 1].nil?
        sides << @map[y - 1][x] if y.positive?
        sides << @map[y + 1][x] unless @map[y + 1].nil?
        low_points << num if sides.all? { |s| num < s }
      end
    end

    puts low_points.map { |l| l + 1 }.sum
  end

  def read_input
    File.read('input.txt').split("\n").map { |l| l.split('').map(&:to_i) }
  end
end

HeightMap.new.execute
