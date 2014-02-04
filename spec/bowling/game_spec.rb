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

  shared_examples "calculate score" do |points|
    it "scores #{points} points" do
      expect(subject.score).to eq(points)
    end
  end

  context "only miss game" do
    before do
      20.times { subject.roll(0) }
    end

    it_behaves_like "calculate score", 0
  end

  context "knocks 5 pins and a miss per frame" do
    before do
      10.times do
        subject.roll(5)
        subject.roll(0)
      end
    end

    it_behaves_like "calculate score", 50
  end

  context "knocks a spare, 5 in next turn and just misses" do
    before do
      3.times { subject.roll(5) }
      17.times { subject.roll(0) }
    end

    it_behaves_like "calculate score", 20
  end

  context "knocks misses, a spare in the last frame, and a 5 next" do
    before do
      18.times { subject.roll(0) }
      3.times { subject.roll(5) }
    end

    it_behaves_like "calculate score", 15
  end

  context "knocks a strike then two 4's and just misses" do
    before do
      subject.roll(10)
      2.times { subject.roll(4) }
      16.times { subject.roll(0) }
    end

    it_behaves_like "calculate score", 26
  end

  context "knocks misses, a strike in last frame and two 4's" do
    before do
      18.times { subject.roll(0) }
      subject.roll(10)
      2.times { subject.roll(4) }
    end

    it_behaves_like "calculate score", 18
  end

  context "knocks misses, a strike in last frame and two 10's" do
    before do
      18.times { subject.roll(0) }
      3.times { subject.roll(10) }
    end

    it_behaves_like "calculate score", 30
  end

  context "perfect game" do
    before do
      12.times { subject.roll(10) }
    end

    it_behaves_like "calculate score", 300
  end
end
