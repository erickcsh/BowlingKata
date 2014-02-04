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
        score += first_try + (second_try || 0)
        score += @turns_results[count + 2] + @turns_results[count + 3] if first_try == 10
        score += spare_result(count) if spare?(first_try, second_try)
        count += first_try == 10 ? 1 : 2
      end
      score
    end

    private
    def frame_tries(count)
      first_try = @turns_results[count]
      second_try = first_try == 10 ? nil : @turns_results[count + 1]
      [first_try, second_try]
    end

    def spare?(first_try, second_try)
      first_try + (second_try || 0) == 10
    end

    def spare_result(count)
      @turns_results[count + 2]
    end

    def valid_frame?(count)
      count < [@turns_results.size, LAST_FRAME].min
    end
  end
end
