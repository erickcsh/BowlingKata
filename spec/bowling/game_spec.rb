require 'bowling/game.rb'

describe Bowling::Game, "#roll" do

  subject{ described_class.new }

  after do
    subject.roll(0)
  end

  it "adds number of knocked pins to the turn result" do
    expect(subject.turns_results.size).to eq(0)
  end
end

describe Bowling::Game, "#score" do

  subject{ described_class.new }

  context "only miss game" do
    before do
      20.times { subject.roll(0) }
    end

    it "scores 0 points" do
      expect(subject.score).to eq(0)
    end
  end

  context "perfect game" do
    before do
      12.times { subject.roll(10) }
    end

    it "scores 300 points" do
      expect(subject.score).to eq(300)
    end
  end
end
