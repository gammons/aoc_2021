class Pairs
  def execute
    template, @pair_insertions = read_input
    @element_count = {}

    template.each do |element|
      @element_count[element] ||= 0
      @element_count[element] += 1
    end

    new_additions = {}
    calculate_pairs(template).each do |pair|
      new_additions[pair] ||= 0
      new_additions[pair] += 1
    end

    40.times do
      new_additions = process_additions(new_additions)
    end

    max = @element_count.max { |e1, e2| e1[1] <=> e2[1] }
    min = @element_count.min { |e1, e2| e1[1] <=> e2[1] }
    puts max[1] - min[1]
  end

  def process_additions(additions)
    new_additions = {}
    additions.each do |pair, count|
      s1 = pair.split('')[0] + @pair_insertions[pair]
      s2 = @pair_insertions[pair] + pair.split('')[1]

      @element_count[@pair_insertions[pair]] ||= 0
      @element_count[@pair_insertions[pair]] += count

      new_additions[s1] ||= 0
      new_additions[s1] += count

      new_additions[s2] ||= 0
      new_additions[s2] += count
    end
    new_additions
  end

  def calculate_pairs(pair_string)
    pairs = []
    idx = 0
    while idx < pair_string.length - 1
      pairs << pair_string[idx] + pair_string[idx + 1]
      idx += 1
    end
    pairs
  end

  def read_input
    input = File.readlines('input.txt').map(&:chomp)
    template = input[0].split('')
    pair_insertions = {}

    input[2..(input.length - 1)].each do |i|
      pair_insertions[i.split(' -> ')[0]] = i.split(' -> ')[1]
    end

    [template, pair_insertions]
  end
end

Pairs.new.execute
