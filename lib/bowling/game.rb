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
      score = 0
      count = 0
      while count < @turns_results.size do
        first_try = @turns_results[count]
        second_try = @turns_results[count + 1]
        score += first_try + second_try
        if(first_try + second_try == 10)
          score += @turns_results[count + 2]
        end
        count += 2
      end
      score
    end
  end
end
