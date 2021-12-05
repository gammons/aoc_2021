require 'byebug'

class Diagram
  attr_reader :lines

  def initialize
    @lines = []
  end

  def add_line(line)
    @lines << line
  end

  def intersections
    points = {}
    @lines.each do |line|
      line.points.each do |point|
        existing = points[[point.x, point.y]]
        points[[point.x, point.y]] = existing.nil? ? 1 : existing + 1
      end
    end
    points
  end
end

class Coord
  attr_accessor :x, :y

  def initialize(c)
    @x = c[0].to_i
    @y = c[1].to_i
  end

  def to_s
    "(#{@x},#{@y})"
  end
end

class Line
  attr_accessor :start, :end

  def initialize(start_coord, end_coord)
    @start = start_coord
    @end = end_coord
  end

  def is_diagonal
    (@start.x - @end.x).abs == (@start.y - @end.y).abs
  end

  def points
    if @start.x == @end.x
      if @start.y < @end.y
        @start.y.upto(@end.y).map { |n| Coord.new([@start.x, n]) }
      else
        @start.y.downto(@end.y).map { |n| Coord.new([@start.x, n]) }
      end
    elsif @start.y == @end.y
      if @start.x < @end.x
        @start.x.upto(@end.x).map { |n| Coord.new([n, @start.y]) }
      else
        @start.x.downto(@end.x).map { |n| Coord.new([n, @start.y]) }
      end

    elsif is_diagonal
      p_x = @start.x < @end.x ? @start.x.upto(@end.x).to_a : @start.x.downto(@end.x).to_a
      p_y = @start.y < @end.y ? @start.y.upto(@end.y).to_a : @start.y.downto(@end.y).to_a
      coords = ((@start.x - @end.x).abs + 1).times.map do |n|
        Coord.new([p_x[n], p_y[n]])
      end
      coords
    else
      []
    end
  end
end

class Vents
  def execute
    read_input
    # puts @diagram.lines.map { |l| "#{l.start} #{l.end} #{l.is_diagonal}" }
    puts @diagram.intersections.select { |_k, v| v >= 2 }.count
  end

  def read_input
    @diagram = Diagram.new
    File.read('input.txt').split("\n").each do |line|
      p1, p2 = line.split(' -> ')
      @diagram.add_line Line.new(Coord.new(p1.split(',')), Coord.new(p2.split(',')))
    end
  end
end

Vents.new.execute
