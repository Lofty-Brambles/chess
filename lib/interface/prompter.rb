# frozen_string_literal: true

require_relative 'color_codes'

# acts as a DI indulgent method of prompting
class Prompt
  using ColorCodes

  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
  end

  def ask(text, invalid_text = nil)
    @output.print prettify(text)
    loop do
      input = @input.gets.chomp
      return input if !block_given? || yield(input)

      @output.print prettify(invalid_text)
    end
  end

  def prettify(text)
    "\n#{'[ Q ]'.color(:yellow)} #{text} #{' ⇒  '.color(:yellow)}"
  end
end
