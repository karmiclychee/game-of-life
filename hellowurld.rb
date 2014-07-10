require 'gosu'
require_relative 'grid'

module Evolve
  class Window < Gosu::Window
    def initialize
      @height = @width = 640
      super(@width, @height, false)
      self.caption = 'Hello World!'
      self
    end

    def draw
      grid = Evolve::Grid.build(@width, @height, scale: 10, padding: 0.75)
      color = Gosu::Color::CYAN
      grid.each do |tile|
        x = tile.x * grid.scale
        y = tile.y * grid.scale
        padding = grid.padding

        coordinates = [
          x + padding,                  y + padding,                  color,
          x + grid.scale - (padding*2), y + padding,                  color,
          x + padding,                  y + grid.scale - (padding*2), color,
          x + grid.scale - (padding*2), y + grid.scale - (padding*2), color
        ]

        draw_quad *coordinates
      end
    end
  end
end

window = Evolve::Window.new
window.show