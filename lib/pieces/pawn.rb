# frozen_string_literal: true

require_relative 'base'
require_relative '../errors'
require_relative  '../utils/piece_helpers'

class Pawn < Base
  include PieceHelpers

  def initialize(character, position)
    invalide_pawn_placement = InvalidFENError.new('The pawn placement is invalid.')
    raise invalide_pawn_placement unless position[0].between?(1, 6)

    super
  end
end
