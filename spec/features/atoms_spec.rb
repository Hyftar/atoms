require_relative '../../lib/interpreter.rb'
require 'byebug'

describe 'Tests data entry' do
  before(:each) do
    @interpreter = Interpreter.new
  end

  describe 'Invalid input' do
    it 'should raise an error' do
      expect { @interpreter.read('z') }.to raise_error(SyntaxError)
    end
  end

  describe 'The Prime atom' do
    it 'should figure if numbers are primes' do
      @interpreter.read('5,9,7,3,100P')
      expect(@interpreter.last_vector).to eq([true, false, true, true, false])
    end
  end

  describe 'The Pop atom' do
    it 'should pop the last element' do
      @interpreter.read('5 10 15p')
      expect(@interpreter.stack.size).to eq(2)
      expect(@interpreter.top).to eq(10)
    end

    # TODO: Figure if bug or feature
    it 'should continue a number' do
      @interpreter.read('5 5p10')
      expect(@interpreter.top).to eq(510)
      expect(@interpreter.stack.size).to eq(1)
    end
  end
end
