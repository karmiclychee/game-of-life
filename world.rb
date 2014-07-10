module Evolve
  class World
    include Enumerable

    def self.build(limitX = 10, limitY = 10, scale: 10)
      grid = []

      (limitX/scale).times do |cell|
        (limitY/scale).times { |row| grid << Cell.new(cell, row) }
      end

      new grid, scale, [limitX/scale, limitY/scale]
    end

    def each
      @grid.each do |tile|
        return to_enum(__method__) unless block_given?
        yield tile
      end
    end

    def seed
      (dimensions[0] * dimensions[1] * 0.25).to_i.times do |x|
        get_tile(rand(dimensions[0]), rand(dimensions[1])).vivify
      end
    end

    def get_tile(x, y)
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

        @genome[:skin] = Gosu::Color.argb(255, rand(0...255), rand(0...255), rand(0...255)) if rand(100) > 97
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
end