# frozen_string_literal: true

require_relative '../../lib/game/init_loop'
require_relative '../../lib/interface/prompt'

RSpec.describe InitLoop do
  def generate_game(*args)
    input_str = StringIO.new "#{args.join("\n")}\n"
    output_str = StringIO.new
    InitLoop.new(input_str, output_str)
  end

  context 'when the game is supposed to run only once' do
    it 'exits after only one run' do
      game = generate_game(2, 'no')
      allow(game).to receive(:play_mode)
      expect(game).to receive(:play_mode).once
      game.run
    end
  end

  context 'when the game is supposed to run a few times' do
    it 'exits only after the required times mentioned' do
      game = generate_game(3, 'yes', 3, 'y', 1, 'no')
      allow(game).to receive(:play_mode)
      expect(game).to receive(:play_mode).thrice
      game.run
    end
  end
end
