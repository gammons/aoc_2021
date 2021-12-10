class Syntax
  def execute
    lines = read_input
    score = 0

    lines.each do |line|
      stack = []

      line.split('').each do |char|
        if ['(', '[', '{', '<'].include?(char)
          stack << char
        else
          if char == closer_for(stack.last)
            stack.pop
          else
            score += score_for(char)
            break
          end
        end
      end
    end

    puts score
  end

  def score_for(char)
    case char
    when ')'
      3
    when ']'
      57
    when '}'
      1197
    when '>'
      25_137
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
