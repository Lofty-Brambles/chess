# frozen_string_literal: true

# the base piece class that defines the common structure to all pieces
class Piece
  def initialize(color, square)
    @color = color
    @square = square
  end
end
