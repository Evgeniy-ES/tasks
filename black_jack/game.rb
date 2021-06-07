class Game
  require_relative 'all_modules'
  require_relative 'pack'
  require_relative 'user'

  include AuxiliaryMethods

  def initialize
    @actions = %w[exit_game say_name]
    @name_user = enter_name
    begin_game
  end

  def begin_game
    finish_game = begin_game0
    while finish_game == false
      begin_game1
      choise
      open_cards
      finish_game = finsh_game_func
    end
    puts '====== END GAME ========'
  end

  def begin_game0
    @user = User.new(@name_user)
    @diller = User.new('Diller')
    puts '====== BEGIN GAME ========'
    false
  end

  def begin_game1
    puts '====== Begin round ========'
    @pack = Pack.new
    @user.cards_user = @pack.add_card(2, [])
    @diller.cards_user = @pack.add_card(2, [])
    view_players('hide')
  end

  def view_players(mode)
    view_user(@diller, mode)
    view_user(@user, 'show')
  end

  def view_user(user_data, mode)
    puts "Player: #{user_data.name}"
    print 'Cards:'
    view_user0(user_data, mode)
    puts
  end

  def view_user0(user_data, mode)
    if mode == 'hide'
      user_data.cards_user.each { print ' *' }
      puts '  Sum: ???'
    else
      user_data.cards_user.each { |x| print " #{x}" }
      puts "  Sum: #{user_data.calculation_sum(@pack.score)}"
    end
  end

  def add_card(user_name = @user.name)
    puts "******** user_name #{user_name}"
    if user_name == 'Diller'
      @diller.cards_user = @pack.add_card(1, @diller.cards_user)
    else
      @user.cards_user = @pack.add_card(1, @user.cards_user)
    end
  end

  def action_bank(sum0, sum1)
    @diller.bank += sum0
    @user.bank += sum1
  end

  def open_cards_check(sum_diller, sum_user)
    if sum_diller > sum_user && sum_diller <= 21
      victory(@diller)
    elsif sum_user > 21
      victory(@diller)
    else
      victory(@user)
    end
  end

  def open_cards
    view_players('show')
    sum_diller = @diller.calculation_sum(@pack.score)
    sum_user = @user.calculation_sum(@pack.score)
    if (sum_diller > 21 && sum_user > 21) || (sum_diller == sum_user)
      puts 'raw'
    else
      open_cards_check(sum_diller, sum_user)
    end
    puts '====== End round ========'
    puts
  end

  def victory(user)
    puts "Victory #{user.name}"
    if user.name == 'Diller'
      action_bank(10, -10)
    else
      action_bank(-10, 10)
    end
  end

  def open_cards0(data_user)
    puts "Player: #{data_user.name}"
    print 'Cards:'
    data_user.cards_user.each { print ' *' }
    puts "  Sum: #{data_user.calculation_sum(@pack.score)}"
    data_user.calculation_sum(@pack.score)
  end

  def choise0(user_choise)
    criterion0 = @user.cards_user.length
    criterion1 = @diller.cards_user.length
    if (user_choise == 2) || (criterion0 == 3 && criterion1 == 3)
      true
    else
      view_players('hide')
    end
  end

  def choise
    condition0 = nil
    while condition0.nil?
      i = -1
      array_choise = ['skip', 'add card', 'open cards']
      array_choise.each { |x| puts "#{x}   -  #{i += 1}" }
      user_choise = enter_choise
      send(str_for_send(array_choise[user_choise]))
      skip if user_choise == 1
      condition0 = choise0(user_choise)
    end
  end

  def skip
    condition0 = @diller.calculation_sum(@pack.score)
    add_card(@diller.name) if condition0 < 17 && @diller.cards_user.length < 3
  end
end
