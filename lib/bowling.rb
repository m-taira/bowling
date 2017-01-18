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
      @total_score += score.inject(:+) + bonus_point(i)
    end
  end
  
  private
  
  def bonus_point(index)
    if strike?(@scores[index]) && not_last_frame?(index)
      calc_strike_bonus(index)
    elsif spare?(@scores[index]) && not_last_frame?(index)
      calc_spare_bonus(index)
    else
      0
    end
  end
  
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
      @scores[index + 1].first + @scores[index + 2]&.first.to_i
    else
      @scores[index + 1].first + @scores[index + 1].last
    end
  end
end
