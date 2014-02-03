require 'bowling/game.rb'

describe Bowling::Game, "#roll" do

  subject{ described_class.new.roll(0) }
end
