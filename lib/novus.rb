class MathMachine
  def initialize(operators=[:+, :-, :*, :/])
    @operators = operators
    @result = nil
    self.run
  end

  def run
    render_greeting
    @input = gets.chomp

    until @input == 'quit'
      puts "Parsing input..."
      parse_input(@input)
      render_result
      @input = gets.chomp
    end

    puts "Have a Nice Day!"
  end

  private
  def calculate(int_arr, operand)
    return int_arr.inject(&operand)
  end

  def check_operands(split_input, operands)
    split_input.each_with_index do |char, idx|
      if operands.include?(char)
        # perform operations on preceeding and succeeding characters
        # delete characters from the array
        int_arr = [split_input[idx - 1].to_i, split_input.delete_at(idx + 1).to_i]
        operand = split_input.delete_at(idx)
        split_input[idx - 1] = calculate(int_arr, operand.to_sym)
      end
    end

    return split_input
  end

  # Order of Operations is: Multiply, Divide, Add, Subtract. Left to Right.
  def parse_input(input)
    split_input = input.split('')

    # Perform first pass left to right, execute any Multiplication & Divsion
    split_input = check_operands(split_input, ['*', '/'])

    # Perform second pass left to right, execute any Addition & Subtraction
    split_input = check_operands(split_input, ['+', '-'])

    @result = split_input.first
  end

  def render_greeting
    system 'clear'
    filler = ['='] * 60

    puts filler.join('')
    puts "| Welcome to the Math Machine!  Your Arithmetic Simulator. |"
    puts filler.join('')
    puts "| 1. Simply enter an arithmetic string to begin (i.e. 1+4) |"
    puts "| 2. 'quit' exits the program.                             |"
    puts "| 3. The current version supports Addition(+),             |"
    puts "|  Subtraction(-), Multiplication(*), and Division(/).     |"
    puts filler.join('')
  end

  def render_result
    if @result
      puts @input + ' = ' + @result.to_s
    else
      puts "Invalid Input. Please Try Again."
    end
  end
end