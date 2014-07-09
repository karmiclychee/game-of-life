require 'gosu'
require_relative 'grid'

class MyWindow < Gosu::Window
  def initialize
    @height = @width = 640
    super(@width, @height, false)
    self.caption = 'Hello World!'
    self
  end

  def draw
    grid = Grid.build
    color = Gosu::Color::CYAN
    grid.each do |tile|
      x = tile.x * grid.scale
      y = tile.y * grid.scale

      coordinates = [
        x,                y,                color,
        x + grid.scale,   y,                color,
        x,                y + grid.scale,   color,
        x + grid.scale,   y + grid.scale,   Gosu::Color::BLACK
      ]

      draw_quad *coordinates
    end
  end
end



window = MyWindow.new
window.show