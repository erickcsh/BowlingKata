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
      count = score = 0
      while count < @turns_results.size do
        frame = frame_tries(count)
        score += frame_score(frame) + bonus_score(frame, count)
        count += count_jump(frame, count)
      end
      score
    end

    private
    def count_jump(frame, count)
      case
      when strike?(frame) then strike_jump(count)
      when spare?(frame) then spare_jump(count)
      else 2
      end
    end

    def strike_jump(count)
      count + 1 == @turns_results.size - 2 ? 3 : 1
    end

    def spare_jump(count)
      count + 2 == @turns_results.size - 1 ? 3 : 2
    end

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
  end
end
