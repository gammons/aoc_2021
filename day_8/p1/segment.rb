class Runner
  def execute
    input = read_input
    count = 0

    input.each do |line|
      line[1].split(' ').each do |output_num|
        count += 1 if [2, 3, 4, 7].include?(output_num.length)
      end
    end
    puts count
  end

  private

  def read_input
    File.read('input.txt').split("\n").map { |l| l.split(' | ') }
  end
end

Runner.new.execute
