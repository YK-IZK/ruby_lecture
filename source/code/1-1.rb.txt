class Player
  def initialize(name)
    @name = name
    @hands = []
  end

  def add_hands(hand)
    @hands << hand
  end

  def show_hands
    @hands.map{ |hand| hand.show }.join(',')
  end

  def calc_score
    ranks = @hands.map{ |hand| hand.rank}.sort{ |a, b| b <=> a}

    @score = ranks.inject(0) do |score, rank|
      if rank > 10
        score += 10
      elsif rank == 1
        score += (score + 11 > 21) ?  1 : 11
      else
        score += rank
      end
    end
  end

  attr_reader :name, :hands
end
