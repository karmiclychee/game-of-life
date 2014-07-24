require 'gosu'
require_relative 'simulation'

module Evolve
  class Window < Gosu::Window
    SPACE_KEY = 49
    ESC_KEY = 53
    CLICK = 256

    def initialize
      height = width = 640
      super(width, height, false, 1)
      new_simulation
      @font = Gosu::Font.new(self, 'Helvetica', 14)
      @pause = false
      self.caption = 'Dat Game o\' Life'
      self
    end

    private

    def new_simulation
      @simulation = Evolve::Simulation.new(
        Evolve::World.build(20, 20, self)
      )
    end

    def paused?
      @pause
    end

    def button_down(id)
      case id
      when CLICK then @pause = !@pause
      when ESC_KEY then close
      when SPACE_KEY then new_simulation
      end
      @button_id = id
    end

    def update
      @simulation.step unless paused?
    end

    def corner_text
      "#{paused? ? "PAUSED" : @simulation.generation} | SPACE to restart, CLICK to pause, ESC to exit"
    end

    def draw
      @font.draw @button_id, 0, 20, 1
      @font.draw corner_text, 0, 0, 1
      @simulation.get_coordinates.each do |coordinates_set|
        draw_quad *coordinates_set
      end
    end
  end
end