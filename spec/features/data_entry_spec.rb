require_relative '../../lib/interpreter.rb'
require 'byebug'

describe 'Tests data entry' do
  before(:each) do
    @interpreter = Interpreter.new
  end

  describe 'Tests decimal data entry' do
    it 'should input 254' do
      @interpreter.read('254')
      expect(@interpreter.top).to eq(254)
    end

    it 'should input 0' do
      @interpreter.read('0')
      expect(@interpreter.top).to eq(0)
    end

    it 'should input 10000' do
      @interpreter.read('10000')
      expect(@interpreter.top).to eq(10_000)
    end

    it 'should input [8, 12, 18]' do
      @interpreter.read('8,12,18')
      expect(@interpreter.last_vector).to eq([8, 12, 18])
    end

    it 'should input 3 one digit vectors' do
      @interpreter.read('8 5 2')
      expect(@interpreter.top).to eq(2)
      expect(@interpreter.stack.size).to eq(3)
    end
  end

  describe 'Tests float data entry' do
    it 'should input 0.5' do
      @interpreter.read('ƒ5')
      expect(@interpreter.top).to eq(0.5)
    end

    it 'should input 1.20' do
      @interpreter.read('1ƒ2')
      expect(@interpreter.top).to eq(1.2)
    end

    it 'should input 500.0005 and 1.1' do
      @interpreter.read('500ƒ0005,1ƒ1')
      expect(@interpreter.last_vector).to eq([500.0005, 1.1])
    end
  end

  describe 'Test hexadecimal data entry' do
    it 'should input 255' do
      @interpreter.read('ff')
      expect(@interpreter.top).to eq(255)
    end

    it 'should input 3.14159265358979323846' do
      @interpreter.read('h3ƒ243F6A8885A3')
      expect(@interpreter.top).to eq(3.14159265358979323846)
    end

    it 'should input 3.14159265358979323846' do
      @interpreter.read('h3ƒ243f6a8885a3')
      expect(@interpreter.top).to eq(3.14159265358979323846)
    end
  end

  describe 'Test binary data entry' do
    it 'should input 255' do
      @interpreter.read('ƀ11111111')
      expect(@interpreter.top).to eq(255)
    end

    it 'should input 696' do
      @interpreter.read('ƀ1010111000')
      expect(@interpreter.top).to eq(696)
    end
  end

  describe 'Test string data entry' do
    it 'should input "hello world!"' do
      @interpreter.read('"hello world!"')
      expect(@interpreter.last_vector).to eq(
        ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd', '!']
      )
    end

    it 'should terminate strings on its own' do
      @interpreter.read('"hello world!')
      expect(@interpreter.last_vector).to eq(
        ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd', '!']
      )
    end

    it 'should return to normal mode' do
      @interpreter.read('"hello world!" 255')
      expect(@interpreter.top).to eq(255)
    end
  end
end
