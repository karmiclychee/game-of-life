require_relative 'cell'

module Evolve
  class World
    include Enumerable

    def self.build(limitX = 10, limitY = 10, scale = 10)
      grid = []

      (limitX/scale).times do |cell|
        (limitY/scale).times { |row| grid << Evolve::Cell.new(cell, row) }
      end

      new grid, scale, [limitX/scale, limitY/scale]
    end

    def each
      return to_enum(__method__) unless block_given?
      @grid.each do |tile|
        yield tile
      end
    end

    def seed
      (dimensions[0] * dimensions[1] * 0.12).to_i.times do |x|
        get_tile(rand(dimensions[0]), rand(dimensions[1])).vivify
      end
    end

    def get_tile(x, y)
      x = 0 if x > dimensions[0] - 1
      y = 0 if y > dimensions[1] - 1
      x = dimensions[0] - 1 if x < 0
      y = dimensions[1] - 1 if y < 0
      @grid.select { |tile| tile.x == x && tile.y == y }[0]
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

    attr_reader :grid, :scale, :dimensions
    private

    def initialize(grid, scale, dimensions)
      @scale = scale
      @grid = grid
      @dimensions = dimensions
    end
  end
end