class Crab
  def execute
    numbers = read_input
    avg = (numbers.sum(0) / numbers.size).round

    total = numbers.inject(0) do |sum, n|
      steps = (n - avg).abs
      sum + ((1..steps).inject(:+) || 0)
    end
    puts "Sum = #{total}"
  end

  private

  def read_input
    File.readlines('input.txt')[0].chomp.split(',').map(&:to_i)
  end
end

Crab.new.execute
