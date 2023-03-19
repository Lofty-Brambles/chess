# frozen_string_literal: true

require_relative '../../lib/interface/color_codes'

describe ColorCodes do
  using ColorCodes

  context 'when a black string is necessary' do
    it 'returns a black character ansi key' do
      expect('string'.color(:black)).to eq("\e[30mstring\e[0m")
    end
  end

  context 'when a black background is necessary' do
    it 'returns a black background ansi key' do
      expect('string'.bg_color(:black)).to eq("\e[40mstring\e[0m")
    end
  end

  context 'when a bold string is necessary' do
    it 'returns a bold ansi key' do
      expect('string'.effect(:bold)).to eq("\e[1mstring\e[22m")
    end
  end
end
