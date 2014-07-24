require_relative 'test_helper'

class SimulationTest < Minitest::Test
  def setup
    @mock_world = Minitest::Mock.new
    @mock_world.expect(:seed, nil)
    @simulation = Evolve::Simulation.new @mock_world
  end

  def test_the_simulation_auto_inits
    mock = Minitest::Mock.new
    mock.expect(:seed, nil)
    Evolve::Simulation.new mock
    mock.verify
  end

  def test_the_simulation_iterates_the_world
    @mock_world.expect(:proliferate, nil)
    @mock_world.expect(:cull, nil)

    assert_equal @simulation.generation, 0
    @simulation.step
    @mock_world.verify
    assert_equal @simulation.generation, 1
  end
end