class Crab
  def execute
    numbers = read_input
    med = median(numbers)

    total = numbers.inject(0) do |sum, n|
      sum + (med - n).abs
    end
    puts "Sum = #{total}"
  end

  private

  def read_input
    File.readlines('input.txt')[0].chomp.split(',').map(&:to_i)
  end

  def median(array)
    return nil if array.empty?

    sorted = array.sort
    len = sorted.length
    (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end
end

Crab.new.execute
