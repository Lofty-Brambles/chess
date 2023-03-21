class D
  attr_accessor :j

  def initialize(kind)
    @j = kind
  end
end

class Df < D
  def initialize(king)
    super(king)
  end
end

p Df.new('s').j