require 'gosu'
require_relative 'simulation'

module Evolve
  class Window < Gosu::Window
    def initialize
      height = width = 640
      super(width, height, false, 1)
      self.caption = 'Hello World!'
      @simulation = Evolve::Simulation.new(width, height, scale: 30)
      self
    end

    def update
      @seeded ? @simulation.step : @simulation.world.seed
      @seeded = true
    end

    def draw
      world = @simulation.world
      world.each do |cell|
        x = cell.x * world.scale
        y = cell.y * world.scale

        color = cell.genome[:skin]

        padding = 0.5

        coordinates = [
          x + padding,                    y + padding,                    color,
          x + world.scale - (padding*2),  y + padding,                    color,
          x + padding,                    y + world.scale - (padding*2),  color,
          x + world.scale - (padding*2),  y + world.scale - (padding*2),  color
        ]

        draw_quad *coordinates
      end
    end

  end
end

window = Evolve::Window.new
window.show