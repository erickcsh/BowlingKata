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

  shared_examples "a game score" do |points|
    its(:score) { should == points }
  end

  context "when it is an only miss game" do
    before do
      20.times { subject.roll(0) }
    end

    it_behaves_like "a game score", 0
  end

  context "when it knocks 5 pins and a miss per frame" do
    before do
      10.times do
        subject.roll(5)
        subject.roll(0)
      end
    end

    it_behaves_like "a game score", 50
  end

  context "when it knocks a spare, 5 in next turn and just misses" do
    before do
      3.times { subject.roll(5) }
      17.times { subject.roll(0) }
    end

    it_behaves_like "a game score", 20
  end

  context "when it knocks misses, a spare in the last frame, and a 5 next" do
    before do
      18.times { subject.roll(0) }
      3.times { subject.roll(5) }
    end

    it_behaves_like "a game score", 15
  end

  context "when knocks a strike then two 4's and just misses" do
    before do
      subject.roll(10)
      2.times { subject.roll(4) }
      16.times { subject.roll(0) }
    end

    it_behaves_like "a game score", 26
  end

  context "when knocks misses, a strike in last frame and two 4's" do
    before do
      18.times { subject.roll(0) }
      subject.roll(10)
      2.times { subject.roll(4) }
    end

    it_behaves_like "a game score", 18
  end

  context "when knocks misses, a strike in last frame and two 10's" do
    before do
      18.times { subject.roll(0) }
      3.times { subject.roll(10) }
    end

    it_behaves_like "a game score", 30
  end

  context "when it is a perfect game" do
    before do
      12.times { subject.roll(10) }
    end

    it_behaves_like "a game score", 300
  end
end
