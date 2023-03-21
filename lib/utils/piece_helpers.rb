# frozen_string_literal: true

module PieceHelpers
  def filter_scopeless_moves(move_array)
    move_array.filter do |move|
      move[0].between?(0, 7) && move[1].between?(0, 7)
    end
  end
end
