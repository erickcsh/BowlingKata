module Bowling
  class Game

    ALL_PINS = 10
    STRIKE_NEXT_FRAME = 1
    NEXT_FRAME = 2
    STRIKE_EXTRA_BALLS = 2
    SPARE_EXTRA_BALLS = 1
    NO_BONUS = 0
    GAME_END = 3

    attr_reader :turns_results

    def initialize
      @turns_results = []
    end

    def roll(pins)
      @turns_results << pins
    end

    def score
      frame_first_try = score = 0
      while frame_first_try < @turns_results.size do
        frame = frame_tries(frame_first_try)
        score += frame_score(frame) + bonus_score(frame, frame_first_try)
        frame_first_try += next_frame(frame, frame_first_try)
      end
      score
    end

    private
    def next_frame(frame, frame_first_try)
      case
      when strike?(frame) then strike_jump(frame_first_try)
      when spare?(frame) then spare_jump(frame_first_try)
      else NEXT_FRAME
      end
    end

    def strike_jump(frame_first_try)
      strike_extra_ball_frame?(frame_first_try) ? GAME_END : STRIKE_NEXT_FRAME
    end

    def strike_extra_ball_frame?(frame_first_try)
      frame_first_try + STRIKE_NEXT_FRAME == @turns_results.size - STRIKE_EXTRA_BALLS
    end

    def spare_jump(frame_first_try)
      spare_extra_ball_frame?(frame_first_try) ? GAME_END : NEXT_FRAME
    end

    def spare_extra_ball_frame?(frame_first_try)
      frame_first_try + NEXT_FRAME == @turns_results.size - SPARE_EXTRA_BALLS
    end

    def bonus_score(frame, frame_first_try)
      case
      when strike?(frame) then strike_bonus(frame_first_try)
      when spare?(frame) then spare_bonus(frame_first_try)
      else NO_BONUS
      end
    end

    def frame_score(frame)
      frame[0] + (frame[1] || 0)
    end

    def frame_tries(frame_first_try)
      first_try = @turns_results[frame_first_try]
      second_try = first_try == ALL_PINS ? nil : @turns_results[frame_first_try + 1]
      [first_try, second_try]
    end

    def spare?(frame)
      frame[1] && frame_score(frame) == ALL_PINS
    end

    def strike?(frame)
      frame[0] == ALL_PINS
    end

    def spare_bonus(frame_first_try)
      @turns_results[frame_first_try + 2]
    end

    def strike_bonus(frame_first_try)
      @turns_results[frame_first_try + 1] + @turns_results[frame_first_try + 2]
    end
  end
end
