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

  describe 'The random atom' do
    it 'should add a random digit to the current number' do
      @interpreter.read('10r')
      expect(@interpreter.top).to be_within(5).of(105)
    end
  end

  describe 'The lower case atom' do
    it 'should add all the lower case letters to the last vector' do
      @interpreter.read('5,3l')
      expect(@interpreter.last_vector).to eq([5, 3] + ('a'..'z').to_a)
    end
  end

  describe 'The upper case atom' do
    it 'should add all the upper case letters to the last vector' do
      @interpreter.read('5,3L')
      expect(@interpreter.last_vector).to eq([5, 3] + ('A'..'Z').to_a)
    end
  end

  describe 'The numeric atom' do
    it 'should add all the numbers to the last vector' do
      @interpreter.read('5,3n')
      expect(@interpreter.last_vector).to eq([5, 3] + (0..9).to_a)
    end
  end
end
