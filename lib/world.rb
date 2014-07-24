require_relative 'cell'

module Evolve
  class World
    include Enumerable

    def self.build(limitX = 10, limitY = 10, scale = 10)
      current_grid = []

      (limitX/scale).times do |cell|
        (limitY/scale).times { |row| current_grid << Evolve::Cell.new(cell, row) }
      end

      new current_grid, scale, [limitX/scale, limitY/scale]
    end

    def seed
      (dimensions[0] * dimensions[1] * 0.12).to_i.times do |x|
        get_tile(rand(dimensions[0]), rand(dimensions[1])).vivify
      end
    end

    def proliferate
      @next_grid = @current_grid.map do |cell|
        conway(cell)
      end
    end

    def cull
      @current_grid = @next_grid.clone
      @next_grid = []
    end

    attr_reader :current_grid, :next_grid, :scale, :dimensions

    private

    def initialize(current_grid, scale, dimensions)
      @scale = scale
      @current_grid = current_grid
      @next_grid = []
      @dimensions = dimensions
    end

    def neighbors_for(cell)
      [
        get_tile(cell.x - 1,  cell.y - 1),
        get_tile(cell.x,      cell.y - 1),
        get_tile(cell.x + 1,  cell.y - 1),

        get_tile(cell.x - 1,  cell.y),
        get_tile(cell.x + 1,  cell.y),

        get_tile(cell.x - 1,  cell.y + 1),
        get_tile(cell.x,      cell.y + 1),
        get_tile(cell.x + 1,  cell.y + 1)
      ]
    end

    def get_tile(x, y, generation=:current)
      # this is awful, don't iterate here if you can
      self.send("#{generation}_grid").select do |tile|
        tile.x == x % dimensions[0] && tile.y == y % dimensions[1]
      end[0]
    end


    def conway(cell)
      living_neighbors = neighbors_for(cell).select { |n| n && n.alive? }
      case
      when cell.alive? && ( living_neighbors.length < 2 || living_neighbors.length > 3 )
        cell.clone.decrepify
      when !cell.alive? && living_neighbors.length == 3
        cell.clone.vivify
      else
        cell.clone
      end
    end
  end
end