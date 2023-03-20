# frozen_string_literal: true

# a store for all the color codes
module ColorCodes
  RESET = "\e[0m"
  COLORS = %i[black red green yellow blue magenta cyan gray].freeze
  TYPES = { bold: 1, italic: 3, underline: 4, blink: 5 }.freeze

  refine String do
    def color(name)
      "\e[3#{COLORS.index(name)}m#{self}#{RESET}"
    end

    def bg_color(name)
      "\e[4#{COLORS.index(name)}m#{self}#{RESET}"
    end

    def effect(name)
      "\e[#{TYPES[name]}m#{self}\e[0m"
    end
  end
end
