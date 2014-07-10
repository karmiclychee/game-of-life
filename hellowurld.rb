require 'gosu'
require_relative 'simulation'

module Evolve
  class Window < Gosu::Window
    def initialize
      height = width = 640
      super(width, height, false, 1)
      @simulation = Evolve::Simulation.new(width, height, 25)
      self.caption = 'Hello World!'
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

        color = cell.skin

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