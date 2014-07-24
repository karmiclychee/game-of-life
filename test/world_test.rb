require_relative 'test_helper'

class WorldTest < Minitest::Test
  def setup
    @limit_x = @limit_y = 3
    @width = 20
    @height = 30
    @world = Evolve::World.build(
      @limit_x, @limit_y, OpenStruct.new(width: @width, height: @height)
    )
  end

  def test_the_world_dimensions_match_its_grid
    warn "Single dimensional array is a bad implementation".red
    assert_equal @world.current_grid.length, @limit_y * @limit_x
    assert_equal @world.current_grid.length, @world.dimensions.reduce(:*)
  end

  def test_the_world_knows_the_scale_of_its_cells
    assert_equal @world.scale, [@width/@limit_x, @height/@limit_y].min
  end

  def test_the_world_starts_off_dead
    assert_equal @world.current_grid.select { |cell| cell.alive? }.empty?, true
  end

  def test_the_world_can_seed_itself
    test_the_world_starts_off_dead
    @world.seed
    assert_equal @world.current_grid.select { |cell| cell.alive? }.any?, true
  end

  def test_the_world_can_find_its_cells
    tile = @world.send(:get_cell, 0, 1)
    assert_equal tile.coordinates[:x], 0
    assert_equal tile.coordinates[:y], 1
  end

  def test_the_world_is_a_sphere
    assert_equal @world.send(:get_cell, 1, 3).coordinates, { x: 1, y:0 }
    assert_equal @world.send(:get_cell, 3, 1).coordinates, { x: 0, y:1 }
  end

  def test_the_world_culls_correctly_each_generation
    @world.instance_variable_set(:@next_grid, ["the next grid"])
    @world.cull
    assert_equal *@world.current_grid, "the next grid"
  end
end