module Evolve
  class Simulation
    attr_reader :world

    def initialize(world)
      @world = world
    end

    def step
      world.grid.each do |cell|
        living_neighbors = world.neighbors_for(cell).select { |n| n && n.alive? }
        if cell && cell.alive?
          cell.kill if living_neighbors.length < 2 || living_neighbors.length > 3
        else
          cell.vivify(living_neighbors) if cell && living_neighbors.length == 3
        end
      end
    end
  end
end


# Any live cell with fewer than two live neighbours dies, as if caused by under-population.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any live cell with more than three live neighbours dies, as if by overcrowding.
# Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.