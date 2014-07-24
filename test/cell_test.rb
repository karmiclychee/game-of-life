require_relative 'test_helper'

class CellTest < Minitest::Test
  def setup
    @x = 0
    @y = 1
    @cell = Evolve::Cell.new(
      coordinates: [@x, @y], dimensions: [10, 20]
    )
  end

  def test_cell_default_is_dead
    assert_equal Evolve::Cell.new(
      coordinates:[@x, @y], dimensions: [10, 10]
    ).alive?, false
  end

  def test_cell_can_be_alive
    @cell.vivify
    assert_equal @cell.alive?, true
  end

  def test_cell_can_be_dead
    @cell.decrepify
    assert_equal @cell.alive?, false
  end

  def test_cell_has_a_size
    assert_equal @cell.dimensions[:x], 10
    assert_equal @cell.dimensions[:y], 20
  end

  def test_cell_knows_where_it_is
    assert_equal @cell.coordinates[:x], @x
    assert_equal @cell.coordinates[:y], @y
  end

  def test_cell_knows_where_its_neighbors_are
    [
      [-1, 0],
      [0, 0],
      [1, 0],
      [-1, 1],
      [1, 1],
      [-1, 2],
      [0, 2],
      [1, 2]
    ].each do |coordinates|
      assert_equal @cell.nearest_neighbors.include?(coordinates), true
    end
    assert_equal @cell.nearest_neighbors.include?([@x, @y]), false
  end
end