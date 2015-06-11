ENV['MODE'] = 'TEST'

require 'rspec'
require 'math_machine'

describe MathMachine do
  subject(:math_machine) { MathMachine.new }

  it 'adds two numbers together' do
    expect(math_machine.public_parse_input('1+4')).to be == 5
  end

  it 'subtracts one number from another' do
    expect(math_machine.public_parse_input('3-1')).to be == 2
  end

  it 'multiplies two numbers' do
    expect(math_machine.public_parse_input('2*4')).to be == 8
  end

  it 'divides two numbers' do
    expect(math_machine.public_parse_input('4/2')).to be == 2
  end

  it 'rounds properly when dividing' do
    expect(math_machine.public_parse_input('5/2')).to be == 2
  end

  it 'observes order of operations' do
    expect(math_machine.public_parse_input('1+4*3')).to be == 13
  end
end