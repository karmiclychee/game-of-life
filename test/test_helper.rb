require 'pry'
require 'ostruct'

require 'colorize'
require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

require_relative '../lib/evolve'