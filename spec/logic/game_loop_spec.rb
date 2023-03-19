# frozen_string_literal: true

require_relative '../../lib/logic/game_loop'

describe GameLoop do
  subject(:game_loop) { GameLoop.new }

  context 'when the game\'s end is prompted and a \'ye\' is entered' do
    it 'passes back a TrueClass' do
      expect(game_loop.is_yes?('ye')).to be true
    end
  end

  context 'when the game\'s end is prompted and a \'nada\' is entered' do
    it 'passes back a FalseClass' do
      expect(game_loop.is_yes?('nada')).to be false
    end
  end
end
