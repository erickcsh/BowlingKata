module Bowling
  class Game

    LAST_FRAME = 20

    attr_reader :turns_results

    def initialize
      @turns_results = []
    end

    def roll(pins)
      @turns_results << pins
    end

    def score
      count = score = 0
      while valid_frame?(count) do
        first_try, second_try = frame_tries(count)
        score += first_try + second_try
        score += spare_result(count) if spare?(first_try, second_try)
        count += 2
      end
      score
    end

    private
    def frame_tries(count)
      [@turns_results[count], @turns_results[count + 1]]
    end

    def spare?(first_try, second_try)
      first_try + second_try == 10
    end

    def spare_result(count)
      @turns_results[count + 2]
    end

    def valid_frame?(count)
      count < [@turns_results.size, LAST_FRAME].min
    end
  end
end
