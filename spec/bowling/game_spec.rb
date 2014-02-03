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

  context "knocks 5 pins and a miss per frame" do
    before do
      10.times do
        subject.roll(5)
        subject.roll(0)
      end
    end

    it "scores 50 points" do
      expect(subject.score).to eq(50)
    end
  end
end
