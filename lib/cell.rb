module Evolve
  class Cell
    attr_reader :coordinates, :dimensions, :skin
    DEAD = Gosu::Color::BLACK
    ALIVE = Gosu::Color::GREEN

    def initialize(coordinates:, dimensions:)
      @coordinates = {
        x: coordinates[0],
        y: coordinates[1]
      }

      @dimensions = {
        x: dimensions[0],
        y: dimensions[1]
      }

      @skin = DEAD
      @alive = false
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

    def nearest_neighbors
      [
        [ coordinates[:x] - 1,  coordinates[:y] - 1 ],
        [ coordinates[:x],      coordinates[:y] - 1 ],
        [ coordinates[:x] + 1,  coordinates[:y] - 1 ],
        [ coordinates[:x] - 1,  coordinates[:y]     ],
        [ coordinates[:x] + 1,  coordinates[:y]     ],
        [ coordinates[:x] - 1,  coordinates[:y] + 1 ],
        [ coordinates[:x],      coordinates[:y] + 1 ],
        [ coordinates[:x] + 1,  coordinates[:y] + 1 ]
      ]
    end

    def alive?
      @alive
    end
  end
end