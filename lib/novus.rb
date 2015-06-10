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
  def add
  end

  def divide
  end

  def multiply
  end

  # Order of Operations is: Multiply, Divide, Add, Subtract. Left to Right.
  def parse_input(input) ### '1+2', '1'
    #split on operators? or parse through by character and build a stack?
    @operators.each do |op|
      elements = input.split(op.to_s) ### '[1, 2]', '[1]'

      if elements.length > 1 ### 2, 1
        @result = elements.map do |el|
          parse_input(el) ### 1
        end.inject(op)
      else
        return elements[0].to_i ### 1
      end
    end
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

  def subtract
  end
end