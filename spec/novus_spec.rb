require 'rspec'
require 'novus'

describe MathMachine do
  subject(:math_machine) { MathMachine.new }

  it 'adds two numbers together' do
    math_machine.run
    STDIN.should_receive(:gets).and_return("1+4")
  end

  it 'subtracts one number from another' do

  end

  it 'multiplies two numbers' do

  end

  it 'divides two numbers' do

  end

  it 'rounds properly when dividing' do

  end

  it 'observes order of operations' do

  end
end