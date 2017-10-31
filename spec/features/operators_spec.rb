require_relative '../../lib/interpreter.rb'
require 'byebug'

describe 'Tests the operators' do
  before(:each) do
    @interpreter = Interpreter.new
  end

  describe 'The plus operator' do
    it 'adds 5 to 8' do
      @interpreter.read('5 8+')
      expect(@interpreter.top).to eq(13)
    end

    it 'adds 5, 13 and 10' do
      @interpreter.read('5,13,10+')
      expect(@interpreter.top).to eq(28)
    end

    it 'adds 5 to 8 using only one vector' do
      @interpreter.read('5,8+')
      expect(@interpreter.top).to eq(13)
    end
  end

  describe 'The minus operator' do
    it 'subtracts 5 to 8' do
      @interpreter.read('8 5-')
      expect(@interpreter.top).to eq(3)
    end

    it 'subtracts 5 to 8, 3, 6 and 4' do
      @interpreter.read('8,3,6,4 5-')
      expect(@interpreter.last_vector).to eq([3, -2, 1, -1])
    end

    it 'subtract 5 to 8 using one vector' do
      @interpreter.read('8,5-')
      expect(@interpreter.top).to eq(3)
    end
  end
end
