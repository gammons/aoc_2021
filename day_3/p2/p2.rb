require 'byebug'

def calculate_oxygen_generator(_lines)
  lines = _lines.dup
  lines[0].length.times do |pos|
    zero_count = lines.select { |l| l[pos] == '0' }.length
    one_count = lines.select { |l| l[pos] == '1' }.length

    lines = lines.select { |l| l[pos] == (one_count >= zero_count ? '1' : '0') }
    return lines[0] if lines.length == 1
  end
end

def calculate_co2_scrubber(_lines)
  lines = _lines.dup
  lines[0].length.times do |pos|
    zero_count = lines.select { |l| l[pos] == '0' }.length
    one_count = lines.select { |l| l[pos] == '1' }.length
    least_digit = one_count >= zero_count ? '0' : '1'

    lines = lines.select { |l| l[pos] == least_digit }
    return lines[0] if lines.length == 1
  end
end

def calculate
  lines = File.read('input.txt').split("\n")
  puts calculate_oxygen_generator(lines).to_i(2) * calculate_co2_scrubber(lines).to_i(2)
end

calculate
