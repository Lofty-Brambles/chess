# frozen_string_literal: true

# the error class that exits when thrown
class ExitError < StandardError
  def message
    'The user has asked for a polite exit'
  end
end
