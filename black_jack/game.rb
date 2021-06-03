class Game

  def initialize
    @actions = ['exit_game', 'say_name']
    @bank = 100
    puts "Enter you name please"
    @name_user = gets.chomp.to_s
    begin_game
  end

  def begin_game
    while i == nil
      user = User.new(@user_name)
      diller = User.new('Diller')
      pack = Pack.new
      user.cards_user = pack.add_card(2)
      diller.cards_user = pack.add_card(2)
      view_user(diller)
      view_user(user)

    end
  end

  def view_user(user_data)
    if user_data.name == 'Diller'
      print 'Cards:'
      user_data.cards_user.each { print ' *' }
      puts 'Sum: ???'
    else
      user_data.cards_user.each { |x| print " #{x}" }
      puts "Sum: #{user_data.calculation_sum}"
    end
    puts '----------------------------------'
    puts ''
  end

  def enter_choise
    puts 'Make a selection and press the appropriate key'
    gets.comp.to_i
  end

  def choise
    i = -1
    array_choise = ['skip', 'add card', 'open cards']
    array_choise.each { |x| puts "#{x}   -  #{i += 1}"}
    user_choise = enter_choise
    while condition.nil?
      user_choise.include [1, 2, 3] condition = true : user_choise = enter_choise
    end
    
  end


end
