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
        frame = frame_tries(count)
        score += frame_score(frame) + bonus_score(frame, count)
        print strike?(frame), count, @turns_results.size, "\n"
        break if (strike?(frame)? count + 1 : count) == (strike?(frame)? @turns_results.size - 2 : @turns_results.size)
        count += strike?(frame) ? 1 : 2
      end
      score
    end

    private
    def bonus_score(frame, count)
      case
      when strike?(frame) then strike_bonus(count)
      when spare?(frame) then spare_bonus(count)
      else 0
      end
    end

    def frame_score(frame)
      frame[0] + (frame[1] || 0)
    end

    def frame_tries(count)
      first_try = @turns_results[count]
      second_try = first_try == 10 ? nil : @turns_results[count + 1]
      [first_try, second_try]
    end

    def spare?(frame)
      frame[1] && frame_score(frame) == 10
    end

    def strike?(frame)
      frame[0] == 10
    end

    def spare_bonus(count)
      @turns_results[count + 2]
    end

    def strike_bonus(count)
      @turns_results[count + 1] + @turns_results[count + 2]
    end

    def valid_frame?(count)
      count < [@turns_results.size, LAST_FRAME].min
    end
  end
end
