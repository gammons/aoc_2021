class HeightMap
  def find_neighbors(basin_nodes, x, y)
    return basin_nodes if x.negative? || x >= @map[0].length || y.negative? || y >= @map.length
    return basin_nodes if @map[y][x] == 9
    return basin_nodes if basin_nodes.include?([x, y])

    basin_nodes << [x, y]

    basin_nodes = find_neighbors(basin_nodes, x - 1, y)
    basin_nodes = find_neighbors(basin_nodes, x + 1, y)
    basin_nodes = find_neighbors(basin_nodes, x, y - 1)
    find_neighbors(basin_nodes, x, y + 1)
  end

  def execute
    @map = read_input
    basin_sizes = []

    @map.each_with_index do |row, y|
      row.each_with_index do |num, x|
        sides = []
        sides << row[x - 1] if x.positive?
        sides << row[x + 1] unless row[x + 1].nil?
        sides << @map[y - 1][x] if y.positive?
        sides << @map[y + 1][x] unless @map[y + 1].nil?

        basin_sizes << find_neighbors([], x, y).length if sides.all? { |s| num < s }
      end
    end
    puts basin_sizes.sort.reverse.take(3).inject(:*)
  end

  def read_input
    File.read('input.txt').split("\n").map { |l| l.split('').map(&:to_i) }
  end
end

HeightMap.new.execute
