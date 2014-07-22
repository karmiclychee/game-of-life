require_relative 'world'

module Evolve
  class Simulation
    attr_reader :world, :generation

    def initialize(width, height, scale)
      @world = Evolve::World.build(width, height, scale)
      @generation = 0
      init
    end

    def init
      world.seed
    end

    def step
      @generation += 1
      world.proliferate
      world.cull
    end

    def get_coordinates
      @world.current_grid.map do |cell|
        scale = @world.scale
        color = cell.skin
        padding = 0.5

        x = cell.x * scale
        y = cell.y * scale

        [
          x + padding,              y + padding,              color,
          x + scale - (padding*2),  y + padding,              color,
          x + padding,              y + scale - (padding*2),  color,
          x + scale - (padding*2),  y + scale - (padding*2),  color
        ]
      end
    end
  end
end


# Any live cell with fewer than two live neighbours dies, as if caused by under-population.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any live cell with more than three live neighbours dies, as if by overcrowding.
# Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.