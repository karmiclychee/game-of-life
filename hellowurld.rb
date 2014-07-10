require 'gosu'
require_relative 'world'
require_relative 'simulation'
require 'pry'

module Evolve
  class Window < Gosu::Window
    def initialize
      height = width = 640
      super(width, height, false, 1)
      self.caption = 'Hello World!'
      @world = Evolve::World.build(width, height, scale: 30)
      @simulation = Evolve::Simulation.new(@world)
      self
    end

    attr_reader :world

    def update
      @world.seed unless @seeded
      @seeded = true
      @simulation.step
    end

    def draw
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