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

    describe 'The multiplication operator' do
      it 'multiplies 5 by 8' do
        @interpreter.read('5 8*')
        expect(@interpreter.top).to eq(40)
      end

      it 'multiplies 5 by 1, 4, 8 and 9' do
        @interpreter.read('1,4,8,9 5*')
        expect(@interpreter.last_vector).to eq([5, 20, 40, 45])
      end

      it 'multiplies 5 by 8 using one vector' do
        @interpreter.read('5,8*')
        expect(@interpreter.top).to eq(40)
      end
    end

    describe 'The "and" operator' do
      it '2 and 1' do
        @interpreter.read('1 2&')
        expect(@interpreter.top).to eq(0)
      end

      it '1 and [0, 2, 17, 6]' do
        @interpreter.read('0,2,17,6 1&')
        expect(@interpreter.last_vector).to eq([0, 0, 1, 0])
      end
    end

    describe 'The "or" operator' do
      it '4 or 1' do
        @interpreter.read('4 1|')
        expect(@interpreter.top).to eq(5)
      end

      it '2 or 2' do
        @interpreter.read('2 2|')
        expect(@interpreter.top).to eq(2)
      end

      it '1 or [2, 100, 50, 30]' do
        @interpreter.read('2,100,50,30 1|')
        expect(@interpreter.last_vector).to eq([3, 101, 51, 31])
      end
    end

    describe 'The division operator' do
      it '100 / 25' do
        @interpreter.read('100 25/')
        expect(@interpreter.top).to eq(4)
      end

      it '12 / [36, 48, 60, 24]' do
        @interpreter.read('36,48,60,24 12/')
        expect(@interpreter.last_vector).to eq([3, 4, 5, 2])
      end

      it '100 / 2 / 5' do
        @interpreter.read('100,2,5/')
        expect(@interpreter.top).to eq(10)
      end
    end

    describe 'The modulo operator' do
      it '102 % 25' do
        @interpreter.read('102 25%')
        expect(@interpreter.top).to eq(2)
      end

      it '12 % [35, 54, 60, 21]' do
        @interpreter.read('35,54,60,21 12%')
        expect(@interpreter.last_vector).to eq([11, 6, 0, 9])
      end

      it '98 % 50 % 15' do
        @interpreter.read('98,50,15%')
        expect(@interpreter.top).to eq(3)
      end
    end
  end
end
