# frozen_string_literal: true

require_relative '../interface/static_text'
require_relative '../interface/prompt'
require_relative '../errors'

# the initial game loop wizard to start off with the cli
class InitLoop
  include StaticText

  def initialize(input = $stdin, output = $stdout)
    @prompt = Prompt.new(input, output)
    @output = output
  end

  def run
    show_start_text(@output)

    msg = 'Select an option between 1 and 5'
    invalid_msg = "Invalid input. #{msg}"
    ans = @prompt.ask(msg, invalid_msg) { |input| input.to_i.between?(1, 5) }

    play_mode(ans)
    run if play_again?
    raise ExitError.new

  rescue ExitError
    show_exit_message(@output)
  end

  # TODO
  def play_mode(_option); end

  def play_again?
    @prompt.ask("Would you like to play again? [y|n]").match?(/(y|ye|yes)/i)
  end
end
