# frozen_string_literal: true

require_relative '../interface/color_codes'
require_relative '../interface/prompter'

# the initial game loop wizard to start off with the cli
class GameLoop
  using ColorCodes

  def initialize
    @prompt = Prompt.new
  end

  def run
    show_start_text

    msg = 'Select an option between 1 and 5'
    invalid_msg = "Invalid input. #{message}"
    ans = @prompt.ask(msg, invalid_msg) { |input| input.to_i.between?(1, 5) }

    play_mode(ans)
    raise ExitError.new if !play_again?

  rescue ExitError
    puts "#{'[ 💡 ]'.color(:green)} Thank you for playing!"
  end

  def show_start_text
    puts <<~HEREDOC
      \e[2J\e[H----- ----- ----- ----- ----- -----
           ▄▄·  ▄ .▄▄▄▄ ..▄▄ · .▄▄ ·
          ▐█ ▌▪██▪▐█▀▄.▀·▐█ ▀. ▐█ ▀.
          ██ ▄▄██▀▀█▐▀▀▪▄▄▀▀▀█▄▄▀▀▀█▄
          ▐███▌██▌▐▀▐█▄▄▌▐█▄▪▐█▐█▄▪▐█
          ·▀▀▀ ▀▀▀ · ▀▀▀  ▀▀▀▀  ▀▀▀▀ 
      ----- ----- ----- ----- ----- -----

      #{'Hi there!'.color(:green)} To start with, select one of the following:
        #{'[ 1 ]'.color(:blue)} To start a new #{'Player vs. Player'.effect(:underline)} game.
        #{'[ 2 ]'.color(:blue)} To start a new #{'Player vs. Computer'.effect(:underline)} game.
        #{'[ 3 ]'.color(:blue)} To start from a #{'provided position'.effect(:underline)} [provided a FEN string].
        #{'[ 4 ]'.color(:blue)} To start from a #{'provided game'.effect(:underline)} [provided a PGN string].
        #{'[ 5 ]'.color(:blue)} To start with a #{'saved game'.effect(:underline)}.
        #{'[ 6 ]'.color(:blue)} To start up a #{'tutorial'.effect(:underline)}.
    HEREDOC
  end

  # TODO
  def play_mode(_option); end

  def play_again?
    ans = @prompt.ask("Would you like to play again? [y|n]")
    is_yes?(ans)
  end

  def is_yes?(text)
    text.match?(/(y|ye|yes)/i)
  end
end
