require 'bowling/game.rb'

def roll_game(game, *args)
  args.each { |play| play[0].times { game.roll(play[1]) } }
end

describe Bowling::Game, "#roll" do

  subject{ described_class.new }

  before { roll_game(subject, [1,0]) }

  its(:turns_results) { should == [0] }
end

describe Bowling::Game, "#score" do

  subject{ described_class.new }

  shared_examples "a game score" do |points|
    its(:score) { should == points }
  end

  context "when it is an only miss game" do
    before { roll_game(subject, [20,0]) }

    it_behaves_like "a game score", 0
  end

  context "when it knocks 5 pins and a miss per frame" do
    before { 10.times { roll_game(subject, [1,5],[1,0]) } }

    it_behaves_like "a game score", 50
  end

  context "when it knocks a spare, 5 in next turn and just misses" do
    before { roll_game(subject, [3,5],[17,0]) }

    it_behaves_like "a game score", 20
  end

  context "when it knocks misses, a spare in the last frame, and a 5 in the extra ball" do
    before { roll_game(subject, [18,0],[3,5]) }

    it_behaves_like "a game score", 15
  end

  context "when knocks a strike then two 4's and just misses" do
    before { roll_game(subject, [1,10],[2,4],[16,0]) }

    it_behaves_like "a game score", 26
  end

  context "when knocks misses, a strike in last frame and 4's in the extra balls" do
    before { roll_game(subject, [18,0],[1,10],[2,4]) }

    it_behaves_like "a game score", 18
  end

  context "when knocks misses, a strike in last frame and a strike in the two extra balls" do
    before { roll_game(subject, [18,0],[3,10]) }

    it_behaves_like "a game score", 30
  end

  context "when it is a perfect game" do
    before { roll_game(subject, [12,10]) }

    it_behaves_like "a game score", 300
  end
end
