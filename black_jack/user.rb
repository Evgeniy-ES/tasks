class User
  attr_accessor :cards_user, :bank, :name


  def initialize(cards, user_name)
    @cards_user = cards
    @bank = 100
    @name = user_name
  end

  def calculation_sum
  	for i in (0..@cards_user - 1) do
  	  card = @cards_user[i]
  	  if card.include? "T"
  	  	t = i
  	  else
  	  	sum += @score[card]
  	  end
    end

    unless t.nil?
      if sum + 10 > 21
      	sum += 1
      else
      	sum += 10
      end
    end
  end

  end
