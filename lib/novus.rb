class MathMachine
  def initialize(operators=['+','-','*','/'])
    @operators = operators
    @result = 'Invalid Input. Please Try Again.'
    self.run
  end

  def run
    render_greeting
    input = gets.chomp

    until input == 'quit'
      parse_input(input)
      input = gets.chomp
    end

    return "Have a Nice Day!"
  end

  private
  def add
  end

  def divide
  end

  def multiply
  end

  # Order of Operations is: Multiply, Divide, Add, Subtract. Left to Right.
  def parse_input(input)
    puts "Parsing input: " + input
    #split on operators? or parse through by character and build a stack?
    render_result
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

    puts @result
  end

  def subtract
  end
end