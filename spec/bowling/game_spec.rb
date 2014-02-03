require 'bowling/game.rb'

describe Bowling::Game, "#roll" do

  subject{ described_class.new }

  after do
    subject.roll(0)
  end

  it "adds number of knocked pins to the turn result" do
    expect(turns_results.size).to == 0
  end
end
