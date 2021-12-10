class Syntax
  def execute
    lines = read_input
    scores = []

    lines.each do |line|
      stack = []
      score = 0

      line.split('').each do |char|
        if ['(', '[', '{', '<'].include?(char)
          stack << char
        elsif char == closer_for(stack.last)
          stack.pop
        else
          stack = []
          break
        end
      end

      stack.reverse.map { |s| closer_for(s) }.each do |char|
        score *= 5
        score += score_for(char)
      end
      scores << score if score.positive?
    end

    puts scores.sort[(scores.length / 2)]
  end

  def score_for(char)
    case char
    when ')'
      1
    when ']'
      2
    when '}'
      3
    when '>'
      4
    end
  end

  def closer_for(char)
    case char
    when '('
      ')'
    when '['
      ']'
    when '{'
      '}'
    when '<'
      '>'
    end
  end

  def read_input
    File.read('input.txt').split("\n")
  end
end

Syntax.new.execute
