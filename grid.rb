class Grid
  include Enumerable
  attr_reader :grid, :scale

  def self.build(limitX = 10, limitY = 10, scale = 10)
    grid = []

    limitX.times do |cell|
      limitY.times { |row| grid << Tile.new(cell, row) }
    end

    new grid, scale
  end


  def each
    @grid.each { |tile| yield tile }
  end

  def get_tile(x, y)
    @grid.select {|tile| tile.x == x && tile.y == y }
  end

  private

  def initialize(grid, scale)
    @scale = scale
    @grid = grid
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