class User
  attr_accessor :cards_user, :bank, :name

  def initialize(user_name)
    @bank = 100
    @name = user_name
  end

  def calculation_sum(score)
    sum = 0
    t = false
    @cards_user.each do |element|
      card = element
      card.include?('T') ? t = true : sum += score[card]
    end
    t ? sum : calculation_t(sum)
  end

  def calculation_t(sum)
    sum + 10 > 21 ? sum += 1 : sum += 10
  end
end
