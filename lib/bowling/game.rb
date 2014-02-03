module Bowling
  class Game

    attr_reader :turns_results

    def initialize
      @turns_results = []
    end

    def roll(pins)
      @turns_results << pins
    end

    def score
      @turns_results.reduce(:+)
    end
  end
end
