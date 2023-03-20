# frozen_string_literal: true

require_relative 'color_codes'

module StaticText
  using ColorCodes

  def show_start_text(output)
    output.puts <<~HEREDOC
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

  def show_exit_message(output)
    output.puts "#{'[ 💡 ]'.color(:green)} Thank you for playing!"
  end
end
