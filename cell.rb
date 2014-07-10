module Evolve
  class Cell
    attr_reader :x, :y, :skin
    DEAD = Gosu::Color::BLACK

    def initialize(cell, row)
      @x = cell
      @y = row
      @alive = false
      @skin = DEAD
    end

    def coordinates
      [@x, @y]
    end

    def vivify(progenitors=[])
      @alive = true

      dominant = progenitors.map { |p| p.skin }.uniq.first
      @skin = dominant || Gosu::Color::GREEN

      @skin = Gosu::Color.argb(
        255, rand(0...255), rand(0...255), rand(0...255)
      ) if rand(100) > 97
    end

    def kill
      @alive = false
      @skin = DEAD
    end

    def alive?
      @alive
    end
  end
end