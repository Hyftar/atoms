require_relative 'atoms'

# This class is used to read Atom programs
class Interpreter
  include Atoms

  attr_reader :stack, :base, :mode, :current_exponent

  MODES = %i[normal string float].freeze

  def initialize
    @stack = [[]]
    @base = 10
    @current_exponent = 0
    @mode = MODES.first
  end

  def top
    last_vector.first
  end

  # Returns the last item (vector) on the stack
  def last_vector
    @stack.last
  end

  # Reads the atom code and calls the corresponding atom for each character
  def read(code)
    code.each_char do |char|
      read_character(char)
    end
  end

  private

  def read_character(char)
    case mode
    when :normal, :float
      read_character_normal_mode(char)
    when :string
      read_character_string_mode(char)
    end
  end

  def read_character_normal_mode(char)
    case char
    when '0'..'9', 'a'..'f', 'A'..'F'
      send(:"atom_#{char.downcase}")
    when /\s/
      atom_whitespace
    when '#'
      atom_concat
    when '"'
      atom_string
    when 'h'
      atom_hex
    when 'ƀ' # Latin Small Letter B With Stroke
      atom_bin
    when 'ƒ' # Latin Small Letter F With Hook
      atom_float
    when '-'
      atom_subtract
    when '+'
      atom_add
    when '/'
      atom_divide
    when '%'
      atom_modulo
    when '|'
      atom_or
    when '&'
      atom_and
    when '*'
      atom_multiplication
    when ','
      atom_array
    when 'p'
      atom_pop
    when 'P'
      atom_prime
    when 'r'
      atom_random
    when 'n'
      atom_numeric
    when 'l'
      atom_lower_case_letters
    when 'L'
      atom_upper_case_letters
    else
      raise SyntaxError, 'Unrecognized token'
    end
  end

  def read_character_string_mode(char)
    if char == '"'
      @mode = :normal
    else
      last_vector << char
    end
  end
end
