class Pack
  attr_accessor :game_pack
  attr_reader :score

  def initialize
  	create_game_pack
  end

  def create_game_pack
  	@game_pack = []
    high_cards = ['V', 'D', 'K', 'T']
    suits = ['+', '<3', '^', '<>']
    @score = {}

  	for i in suits do
  	  create_game_pack_dop(i, (2..10))
  	  create_game_pack_dop(i, high_cards)
    end
  end

  def create_game_pack_dop(part_suit, part_array)
  	for j in part_array do
  	  element = j.to_s + part_suit.to_s
  	  @game_pack << element
      @score[element] = j
  	end
  end

  def add_card_in
  	num_card = rand(0..@game_pack.length - 1)
  	card = @game_pack[num_card]
    @game_pack.delete_at(num_card)
    card
  end

  def add_card(volume_card)
    cards_user = []
  	for i in (1..volume_card.to_i) do
  	  cards_user << add_card
    end
    cards_user
  end
end
