# frozen_string_literal: true

require_relative 'base'
require_relative '../errors'
require_relative  '../utils/piece_helpers'

class King < Base
  include PieceHelpers

  INCREMENTS = [[-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1]].freeze

  def initialize(character, position)
    count = @@pieces.filter { |piece| piece.instance_of? King }
    too_many_king_errors = InvalidFENError('The board has too many kings.')
    raise too_many_king_errors if count.length > 1

    invalid_king_position = InvalidFENError('The board has invalid king positions.')
    invalid_places = count.zero? || !count[0].moves(false).include?(position)
    raise invalid_king_position if invalid_places

    super
  end

  def moves(filter_checks = true)
    all = INCREMENTS.map { |key| [key[0] + @position[0], key[1] + @position[1]] }
    filtered_invalids = filter_scopeless_moves(all)
    filter_checks ? filter_checks(filtered_invalids) : filtered_invalid
  end

  def position_in_check(turn, position = @position)
    opponents = @@pieces.filter { |piece| piece.type != turn }

  end
end
