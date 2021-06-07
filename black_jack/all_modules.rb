module AuxiliaryMethods
  def enter_name
    puts 'Enter you name please'
    gets.chomp.to_s
  end

  def enter_choise0
    puts 'Make a selection and press the appropriate key'
    gets.to_i
  end

  def enter_choise
    user_choise = enter_choise0
    check_icld(user_choise)
  end

  def check_icld(user_choise)
    condition = nil
    while condition.nil?
      criterion = [0, 1, 2].include?(user_choise)
      criterion ? condition = true : user_choise = enter_choise
    end
    user_choise
  end

  def str_for_send(str)
    str.tr!(' ', '_')
    str
  end

  def finsh_game_func
    puts 'To end the game press 0, otherwise any key'
    i = gets.chomp.to_s
    if i == '0'
      true
    else
      false
    end
  end
end
