require_relative 'test_helper'

class ConwayTest < Minitest::Test
  def setup
    @world = Evolve::World.build(
      3, 3, OpenStruct.new(width: 30, height: 30)
    )

    @mock_3_by_3_grid = [
      Evolve::Cell.new(coordinates: [0,0], dimensions: 1),
      Evolve::Cell.new(coordinates: [0,1], dimensions: 1),
      Evolve::Cell.new(coordinates: [0,2], dimensions: 1),
      Evolve::Cell.new(coordinates: [1,0], dimensions: 1),
      Evolve::Cell.new(coordinates: [1,1], dimensions: 1),
      Evolve::Cell.new(coordinates: [1,2], dimensions: 1),
      Evolve::Cell.new(coordinates: [2,0], dimensions: 1),
      Evolve::Cell.new(coordinates: [2,1], dimensions: 1),
      Evolve::Cell.new(coordinates: [2,2], dimensions: 1)
    ]
  end

  def test_conways_under_population
    @world.instance_variable_set(:@current_grid, @mock_3_by_3_grid)
    [ [1,1],
      [1,2] ].each { |x_y| @world.send(:get_cell, *x_y).vivify }

    @world.proliferate
    @world.cull
    assert_equal @world.send(:get_cell, 1, 1).alive?, false
  end

  def test_conways_zero_population
    @world.instance_variable_set(:@current_grid, @mock_3_by_3_grid)
    @world.send(:get_cell, 1, 1).vivify

    @world.proliferate
    @world.cull
    assert_equal @world.send(:get_cell, 1, 1).alive?, false
  end

  def test_conways_over_population
    @world.instance_variable_set(:@current_grid, @mock_3_by_3_grid)
    [ [0,1],
      [1,0],
      [1,1],
      [1,2],
      [2,1] ].each { |x_y| @world.send(:get_cell, *x_y).vivify }

    @world.proliferate
    @world.cull
    assert_equal @world.send(:get_cell, 1, 1).alive?, false
  end

  def test_conways_reproduction
    @world.instance_variable_set(:@current_grid, @mock_3_by_3_grid)
    [ [0,1],
      [1,0],
      [1,2] ].each { |x_y| @world.send(:get_cell, *x_y).vivify }

    assert_equal @world.send(:get_cell, 1, 1).alive?, false
    @world.proliferate
    @world.cull
    assert_equal @world.send(:get_cell, 1, 1).alive?, true
  end
end