class Pack
  attr_accessor :game_pack
  attr_reader :score

  def initialize
    create_game_pack
  end

  def add_card(volume_card, cards_user)
    (1..volume_card.to_i).each { cards_user << add_card_in }
    cards_user
  end

  def create_game_pack
    @game_pack = []
    high_cards = %w[V D K T]
    suits = %w[+ <3 ^ <>]
    @score = {}
    suits.each do |i|
      create_game_pack_dop(i, (2..10))
      create_game_pack_dop(i, high_cards, 10)
    end
  end

  def add_card_in
    num_card = rand(0..@game_pack.length - 1)
    @game_pack.delete_at(num_card)
  end

  def create_game_pack_dop(part_suit, part_array, score_card = 0)
    part_array.each do |j|
      element = j.to_s + part_suit.to_s
      @game_pack << element
      @score[element] = if score_card.zero?
                          j
                        else
                          score_card
                        end
    end
  end
end
