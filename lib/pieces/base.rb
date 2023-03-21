# frozen_string_literal: true

class Base
  attr_reader :type, :position

  @@pieces = []

  def initialize(character, position)
    @type = character.match?(/[A-Z]/) ? :white : :black
    @position = position
    @@pieces.push(self)
  end
end
