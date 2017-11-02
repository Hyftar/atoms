require 'prime'

# Atoms (or commands) of the interpreter
module Atoms
  # Creates atoms for digits
  (0..9).each do |digit|
    define_method :"atom_#{digit}" do
      last_vector << 0 if last_vector.empty?
      last_element = last_vector.last
      case @mode
      when :normal
        last_element *= @base
        last_element += digit
      when :float
        @current_exponent -= 1
        last_element += digit * @base**@current_exponent
      end
      last_vector[-1] = last_element
    end
  end

  # Creates atoms for hexadecimal digits
  ('a'..'f').each do |digit|
    define_method :"atom_#{digit}" do
      last_vector << 0 if last_vector.empty?
      last_element = last_vector.last
      case @mode
      when :normal
        last_element *= 16
        last_element += digit.to_i(16)
      when :float
        @current_exponent -= 1
        last_element += digit.to_i(16) * 16**@current_exponent
      end
      last_vector[-1] = last_element
    end
  end

  def atom_prime
    last_vector.map! { |element| Prime.prime? element }
  end

  def atom_pop
    raise ArgumentError, 'Cannot pop an empty stack' if @stack.empty?
    @stack.pop
  end

  def atom_operator(operator)
    @stack[-1] << 0 if last_vector.empty?
    first_vector = @stack.pop
    if first_vector.size > 1
      @stack << [first_vector.reduce(operator)]
    else
      raise ArgumentError, 'Only 1 argument found, requires 2' if @stack.empty?
      second_vector = @stack.pop
      @stack << second_vector.map do |element|
        element.send(operator, first_vector.first)
      end
    end
  end

  def atom_random
    send(:"atom_#{rand(10)}")
  end

  def atom_numeric
    (0..9).each { |digit| @stack[-1] << digit }
  end

  def atom_lower_case_letters
    ('a'..'z').each { |chr| @stack[-1] << chr }
  end

  def atom_upper_case_letters
    ('A'..'Z').each { |chr| @stack[-1] << chr }
  end

  def atom_whitespace
    @stack << [] unless last_vector.empty?
    @current_exponent = 0
    @mode = :normal
  end

  def atom_multiplication
    atom_operator(:*)
  end

  def atom_add
    atom_operator(:+)
  end

  def atom_subtract
    atom_operator(:-)
  end

  def atom_and
    atom_operator(:&)
  end

  def atom_or
    atom_operator(:|)
  end

  def atom_modulo
    atom_operator(:%)
  end

  def atom_divide
    atom_operator(:/)
  end

  def atom_array
    last_vector << 0
    @current_exponent = 0
    @mode = :normal
  end

  def atom_string
    @mode = :string
  end

  def atom_float
    @mode = :float
  end

  def atom_bin
    @base = 2
  end

  def atom_hex
    @base = 16
  end
end
