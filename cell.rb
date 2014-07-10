module Evolve
  class Cell
    attr_reader :x, :y, :genome

    def initialize(cell, row)
      @x = cell
      @y = row
      @alive = false
      @genome = {
        skin: Gosu::Color::BLACK
      }
    end

    def coordinates
      [@x, @y]
    end

    def vivify(progenitors=[])
      @alive = true

      dominant = progenitors.map { |p| p.genome[:skin] }.uniq.first
      @genome = {
        skin: dominant || Gosu::Color::GREEN
      }

      @genome[:skin] = Gosu::Color.argb(
        255, rand(0...255), rand(0...255), rand(0...255)
      ) if rand(100) > 97
    end

    def kill
      @alive = false
      @genome = {
        skin: Gosu::Color::BLACK
      }
    end

    def alive?
      @alive
    end
  end
end