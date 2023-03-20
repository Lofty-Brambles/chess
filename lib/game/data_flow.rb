# frozen_string_literal: true

# the dataflow store for our games
class DataFlow
  DEFAULT_FEN_STRING = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 0'

  def initialize(text = DEFAULT_FEN_STRING)
    data = fen_or_pgn?(text) ? process_fen(text) : process_pgn(text)
  end
end