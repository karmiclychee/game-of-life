require 'gosu'
require_relative 'simulation'

module Evolve
  class Window < Gosu::Window
    def initialize
      height = width = 640
      super(width, height, false, 1)
      @simulation = Evolve::Simulation.new(width, height, 25)
      self.caption = 'Dat Game o\' Life'
      self
    end

    def update
      @seeded ? @simulation.step : @simulation.init
      @seeded = true
    end

    def draw
      @simulation.draw_cells.each do |cell|
        draw_quad *cell
      end
    end

  end
end

window = Evolve::Window.new
window.show