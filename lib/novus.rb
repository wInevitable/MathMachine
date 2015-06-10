class MathMachine
  def initialize(operators=['+', '-', '*', '/'])
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
  # Performs the Actual Calculations
  # Takes in an Array of Two (+) Numbers and an Operator to Apply
  def calculate(int_arr, operand)
    int_arr.inject(&operand)
  end

  # Passes over Parsed Input, on reaching an Operand:
  # Apply it to preceeding and succeeding Numbers
  def check_operands(split_input, operands)
    flag = false

    split_input.each_with_index do |char, idx|
      if operands.include?(char)
        # perform operations on preceeding and succeeding characters
        # delete characters from the array
        int_arr = [split_input[idx - 1].to_f, split_input.delete_at(idx + 1).to_f]
        operand = split_input.delete_at(idx)
        split_input[idx - 1] = calculate(int_arr, operand.to_sym)
        flag = true
      end
    end

    if flag
      return check_operands(split_input, operands)
    else
      return split_input
    end
  end

  # Parses the given string and returns the result of any operations
  def parse_input(input)
    # Split the string on our chosen operands, keeping all characters
    # i.e. '1+23/12' becomes ['1', '+', '23', '/', '12']
    split_input = input.split(/([\+\/\-\*])/).each_slice(1).map(&:join)

    # Order of Operations is: Multiply, Divide, Add, Subtract. Left to Right.
    # Perform first pass Left to Right, execute any Multiplication & Divsion
    split_input = check_operands(split_input, ['*', '/'])

    # Perform second pass Left to Right, execute any Addition & Subtraction
    split_input = check_operands(split_input, ['+', '-'])

    @result = split_input.first.to_i if split_input.first.is_a?(Float)
  end

  # A Simple Greeting to Start the Program with Basic Instructions
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

  # Displays the Result. If none, displays an Error Message
  def render_result
    if @result
      puts @input + ' = ' + @result.to_s
    else
      puts "Invalid Input. Please Try Again."
    end
  end
end

m = MathMachine.new