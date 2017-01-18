class Bowling
  
  def initialize
    @total_score = 0
    
    @scores = [] # [ [10], [10], [5, 4], [9, 1], [10], [10], [10], [1, 0] ... ]
    
    @frame_pins = [] 
  end
  
  def add_score(pins)
    @frame_pins << pins
  
    if @frame_pins.size == 2 || strike?(@frame_pins)
      @scores << @frame_pins
      @frame_pins = []
    end
  end
  
  def total_score
    @total_score
  end
  
  def calc_score
    @scores.each.with_index do |score, i|
      if strike?(score) && not_last_frame?(i)
        @total_score += 10 + calc_strike_bonus(i)
      elsif spare?(score) && not_last_frame?(i)
        @total_score += 10 + calc_spare_bonus(i)
      else
        @total_score += score.inject(:+)
      end
    end
  end
  
  private
  
  def strike?(score)
    score.first == 10
  end
  
  def spare?(score)
    score.inject(:+) == 10 && !strike?(score)
  end
  
  def not_last_frame?(index)
    index < 9
  end
  
  def calc_spare_bonus(index)
    @scores[index + 1].first
  end
  
  def calc_strike_bonus(index)
    if strike?(@scores[index + 1]) && not_last_frame?(index)
      @scores[index + 1].first + @scores[index + 2].first
    else
      @scores[index + 1].first + @scores[index + 1].last
    end
  end
end
