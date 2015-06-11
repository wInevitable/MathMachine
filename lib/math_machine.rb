require 'set'

class MathMachine
  def initialize()
    @operators = [{ 1 => ['*', '/'] }, { 2 => ['+', '-'] }]
    @result = nil
  end

  # The sole Public method of the class.
  # Performs a REPL
  def run
    render_greeting
    @input = $stdin.gets.chomp

    until @input == 'quit'
      parse_input(@input)
      render_result
      @input = $stdin.gets.chomp
    end
  end

  # Here for RSPEC testing
  def public_parse_input(input)
    parse_input(input)
  end

  private
  # Performs the Actual Calculations
  # Takes in an Array of Two (+) Numbers and an Operator to Apply
  def calculate(int_arr, operand)
    int_arr.inject(&operand)
  end

  # Passes over Parsed Input, on reaching an Operand:
  # Apply it to preceeding and succeeding Numbers
  def check_operands(split_input)
    flag = false

    @operators.each do |op_level|
      vals = op_level.values.first # i.e. ['*','/']

      # grab all indices for that level of order of operations
      indices = split_input.each_with_index.select { |char, idx| vals.include?(char) }.map { |pair| pair[1] }

      # execute arithmetic at those indices on that level
      indices.each do |idx|
        if idx > 0
          # perform operations on preceeding and succeeding characters
          # delete previous characters from the array
          int_arr = [split_input[idx - 1].to_f, split_input.delete_at(idx + 1).to_f]
          operand = split_input.delete_at(idx)
          split_input[idx - 1] = calculate(int_arr, operand.to_sym)
          indices.map! { |int| int - 2 } # reduce any remaining indices!
          flag = true
        end
      end
    end

    return split_input
  end

  # Parses the given string and returns the result of any operations
  def parse_input(input)
    # Split the string on our chosen operands, keeping all characters
    # i.e. '1+23/12' becomes ['1', '+', '23', '/', '12']
    ops = @operators.map{ |el| el.values.join('\\') }.join('\\')
    split_input = input.split(/([#{Regexp.quote(ops)}])/).each_slice(1).map(&:join)

    # Order of Operations is: Multiply, Divide, Add, Subtract. Left to Right.
    split_input = check_operands(split_input)

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
      $stdout.puts @result.to_s
      @result = nil
    else
      $stdout.puts "Invalid Input. Please Try Again."
    end
  end
end

if ENV['MODE'] != 'TEST'
  m = MathMachine.new
  m.run
end