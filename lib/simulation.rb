require_relative 'world'

module Evolve
  class Simulation
    attr_reader :world, :generation

    def initialize(world)
      @world = world
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

        x = cell.coordinates[:x] * scale
        y = cell.coordinates[:y] * scale

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