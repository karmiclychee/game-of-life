module Evolve
  class Grid
    include Enumerable
    attr_reader :grid, :scale, :padding

    def self.build(limitX = 10, limitY = 10, scale: 10, padding: 1)
      grid = []

      (limitX/scale).times do |cell|
        (limitY/scale).times { |row| grid << Tile.new(cell, row) }
      end

      new grid, scale, padding
    end

    def each
      @grid.each do |tile|
        return to_enum(__method__) unless block_given?
        yield tile
      end
    end

    def get_tile(x, y)
      @grid.select {|tile| tile.x == x && tile.y == y }
    end

    private

    def initialize(grid, scale, padding)
      @scale = scale
      @grid = grid
      @padding = padding
    end

    class Tile
      attr_reader :x, :y

      def initialize(cell, row)
        @x = cell
        @y = row
      end

      def coordinates
        [@x, @y]
      end
    end
  end
end