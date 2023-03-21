# frozen_string_literal: true

class ExitError < StandardError
  def message
    'This error is thrown to indicate that the user wants to exit the game loop.'
  end
end

class InvalidFENError < StandardError
  def message(text)
    text
  end
end
