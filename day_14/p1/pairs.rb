require 'byebug'

class Pairs
  def execute
    template, pair_insertions = read_input

    10.times do
      template = calculate_pairs(template.join(''))
      template.each_with_index do |pair, idx|
        template[idx] = if idx < template.length - 1
                          pair.split('')[0] + pair_insertions[pair]
                        else
                          pair.split('')[0] + pair_insertions[pair] + pair.split('')[1]
                        end
      end
    end

    quantity = []
    uniq_elements = template.join('').split('').uniq
    uniq_elements.each do |e|
      quantity << template.join('').split('').select { |t| t == e }.count
    end
    puts quantity.max { |q1, q2| q1 <=> q2 } - quantity.min { |q1, q2| q1 <=> q2 }
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
