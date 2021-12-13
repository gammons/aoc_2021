class Paper
  def execute
    @dots, fold_along = read_input

    fold_along.each do |fa|
      fold_vertical(fa[1]) if fa[0] == 'y'
      fold_horizontal(fa[1]) if fa[0] == 'x'
    end
    print
  end

  def print
    puts ''
    max_x = @dots.max { |d1, d2| d1[0] <=> d2[0] }[0] + 1
    max_y = @dots.max { |d1, d2| d1[1] <=> d2[1] }[1] + 1
    max_y.times do |y|
      max_x.times do |x|
        putc @dots.any? { |d| d == [x, y] } ? '#' : '.'
      end
      putc "\n"
    end
  end

  def fold_vertical(crease_at)
    @dots.each_with_index do |dot, idx|
      @dots[idx] = [dot[0], (dot[1] - (dot[1] - crease_at) * 2)] if dot[1] > crease_at
    end
  end

  def fold_horizontal(crease_at)
    @dots.each_with_index do |dot, idx|
      @dots[idx] = [(dot[0] - (dot[0] - crease_at) * 2), dot[1]] if dot[0] > crease_at
    end
  end

  def read_input
    lines = File.readlines('input.txt').map(&:chomp)
    idx = lines.index('')

    dots = lines[0..(idx - 1)]
    dots.map! { |d| [d.split(',')[0].to_i, d.split(',')[1].to_i] }

    fold_along = lines[(idx + 1)..(lines.length - 1)]
    fold_along.map! do |f|
      fa = f.split.last.split('=')
      [fa[0], fa[1].to_i]
    end

    [dots, fold_along]
  end
end

Paper.new.execute
