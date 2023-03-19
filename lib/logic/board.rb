# frozen_string_literal: true

require_relative 'parsers'

# the main state machine for a game
class Board
  include Parsers
  
  DEFAULT_FEN = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 0'

  def initialize(input_string = DEFAULT_FEN, type = :fen)
    @moves = move_string_to_hash(move_string)
    @fen_string = fen_string
    fen_to_board_args(fen_string)
  end

  def move_string_to_hash(move_string)
    # splits at every move, 1. e4 e5 2. Nf3 Nc6 { This is a comment } 3. Bc4 Bc5
    move_array = move_string.split(/\s+\d+\.\s+/)

    move_array.map do |move|
      second_space_index = move.index(' ', move.index(' ') + 1)

      return move.split(' ') if second_space_index.nil?

      move[0, second_space_index + 1].split(' ')
    end
  end

  def fen_to_board_args
    meta_data = @fen_string.split
    parse_board(meta_data[0])
    @turn = meta_data[1] == 'w' ? :white : :black
    @castle_rights = meta_data[2]
    @en_passant = meta_data[3]
    @fifty_turns_tally = meta_data[4].to_i
  end

  def parse_board(fen_fmt)
    @placements = Array.new(8) { Array.new(8) }
    
  end
end
