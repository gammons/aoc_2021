require 'byebug'

class Segment
  attr_accessor :input, :number
end

class Display
  attr_accessor :segments, :mapping
  def initialize
    @mapping = Array.new(9)
  end

  def add_known(input, num)
    @mapping[num] = input
  end

  def deduce(inputs)
    inputs.map! { |i| i.split('').sort.join }

    five_length = inputs.select { |d| d.length == 5 }
    six_length = inputs.select { |d| d.length == 6 }

    @mapping[6] = six_length.reject { |d| @mapping[1].split('').all? { |n| d.split('').include?(n) } }[0]
    @mapping[9] = six_length.select { |d| @mapping[4].split('').all? { |n| d.split('').include?(n) } }[0]
    @mapping[0] = six_length.reject { |d| [@mapping[6], @mapping[9]].include?(d) }[0]

    @mapping[3] = five_length.select { |d| @mapping[1].split('').all? { |n| d.split('').include?(n) } }[0]
    four = @mapping[4].split('') - @mapping[1].split('') # .sort.join
    @mapping[5] = five_length.select { |d| four.all? { |n| d.split('').include?(n) } }[0]
    @mapping[2] = five_length.reject { |d| [@mapping[3], @mapping[5]].include?(d) }[0]
    @mapping.map! { |m| m.split('').sort.join }
  end

  def output_value(output)
    output.map! { |o| o.split('').sort.join }
    mapped = output.map do |o|
      @mapping.index(o).to_s
    end
    mapped.join('').to_i
  end
end

class Runner
  def execute
    input = read_input
    display = Display.new
    outputs = []

    input.each do |line|
      # add known values
      line[0].split(' ').each do |input_num|
        case input_num.length
        when 2
          display.add_known(input_num, 1)
        when 3
          display.add_known(input_num, 7)
        when 4
          display.add_known(input_num, 4)
        when 7
          display.add_known(input_num, 8)
        end
      end

      # now deduce for rest of numbers
      display.deduce(line[0].split(' '))

      # now solve
      outputs << display.output_value(line[1].split(' '))
    end
    puts outputs.sum
  end

  private

  def read_input
    File.read('input.txt').split("\n").map { |l| l.split(' | ') }
  end
end

Runner.new.execute
