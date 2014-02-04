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

  context "knocks a spare, 5 in next turn and just misses" do
    before do
      3.times { subject.roll(5) }
      17.times { subject.roll(0) }
    end

    it "scores 20 points" do
      expect(subject.score).to eq(20)
    end
  end

  context "knocks misses, a spare in the last frame, and a 5 next" do
    before do
      18.times { subject.roll(0) }
      3.times { subject.roll(5) }
    end

    it "scores 15 points" do
      expect(subject.score).to eq(15)
    end
  end

  context "knocks a strike then two 4's and just misses" do
    before do
      subject.roll(10)
      2.times { subject.roll(4) }
      16.times { subject.roll(0) }
    end

    it "scores 26 points" do
      expect(subject.score).to eq(26)
    end
  end

  context "knocks misses, strike in last frame and two 4's" do
    before do
      18.times { subject.roll(0) }
      subject.roll(10)
      2.times { subject.roll(4) }
    end

    it "scores 18 points" do
      expect(subject.score).to eq(18)
    end
  end
end
