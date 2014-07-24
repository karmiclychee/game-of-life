module Evolve
  class Cell
    attr_reader :x, :y, :skin
    DEAD = Gosu::Color::BLACK
    ALIVE = Gosu::Color::GREEN

    def initialize(column, row)
      @x = column
      @y = row
      @skin = DEAD
      @alive = false
    end

    def coordinates
      [@x, @y]
    end

    def vivify
      @skin = ALIVE
      @alive = true
      self
    end

    def decrepify
      @skin = DEAD
      @alive = false
      self
    end

    def alive?
      @alive
    end
  end
end