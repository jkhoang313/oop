class MasterMind

  def initialize
    @colors = ["R", "O", "Y", "G", "B", "I", "V"]
    @turn = 1
    @game_over = false
    @current_guess = Array.new(4)

    puts "How many turns would you like to play?"
    @total_turns = gets.chomp.to_i
    @guess_array = Array.new(@total_turns) {Array.new(4)}
    @hint_array = Array.new(@total_turns) {Array.new(4)}


    puts "Press 1 if you want to guess the secret code and 2 if you want to make the secret code."
    @play = gets.chomp
    puts "\n"
    if @play == "1"
      player_play
    elsif @play == "2"
      ai_play
    else
      puts "Please enter a valid input!"
      initialize
    end
  end

##Player chooses to guess.
  def player_play
    @answer = Array.new(4) {@colors[rand(7)]}
    
    player_turn
  end

  def draw_board(name)
    print "\n"
    puts "#{name} Board"
    puts "-----------------"
    puts "Guesses | Hints"
    puts "-----------------"

    @guess_array.each_with_index do |guess, row_index|
      if guess[0].nil?
        puts "        |        "
        puts "-----------------"
      else
        puts guess.join(" ") + " | " + @hint_array[row_index].join(" ")
        puts "-----------------"
      end
    end 
  end
 
  def player_turn
    while @game_over == false
      draw_board("Your")
      puts "What is your guess? (R O Y G B I V) (W means your guess was wrong in that position)"
      @current_guess = (gets.chomp).upcase.split(" ")
      check_input(@current_guess)

      if @wrong_input == false       
	make_hint
        @guess_array[@turn - 1] = @current_guess
	@turn += 1
        check_game_end_player
      else 
        puts "Please enter a valid guess!"
      end
    end
  end

  def check_input(input)
    input.each do |single|
      if @colors.include?(single) == true && input.length == 4
        @wrong_input = false
      else
        @wrong_input = true
      end
    end
  end

  def make_hint
     @answer.each_with_index do |answer, index|
       if @current_guess[index] == answer
         @hint_array[@turn - 1][index] = answer
       else
         @hint_array[@turn - 1][index] = "W"
       end
     end
  end


  def check_game_end_player
     if @current_guess == @answer
       draw_board("Your")
       puts "You cracked the secret code!"
       @game_over = true    
     elsif @turn > @total_turns
       draw_board("Your")
       puts "You lose! The secret code was #{@answer.join(" ")}."
       @game_over = true
     end
  end

##Player chooses AI to guess.
  def ai_play
    @ai_guess_pool = [["R", "O", "Y", "G", "B", "I", "V"], ["R", "O", "Y", "G", "B", "I", "V"], ["R", "O", "Y", "G", "B", "I", "V"], ["R", "O", "Y", "G", "B", "I", "V"]]
    @final_answer = Array.new(4)

    puts "Enter your secret code!"
    @answer = gets.chomp.upcase.split(" ")
    check_input(@answer)
   
    if @wrong_input == false       
      ai_turn
    else 
      puts "Please enter a valid code!"
      ai_play
    end
  end

  def ai_turn
    while @game_over == false
      draw_board("Computer's")
      ai_guess
      make_hint
      @turn += 1
      check_game_end_ai
    end
  end

  def ai_guess
    @ai_guess_pool.each_with_index do |answer_pool, position|
      @sample = answer_pool.sample
      @current_guess[position] = @sample
      @guess_array[@turn - 1][position] = @sample

      if @answer[position] == @sample
        @ai_guess_pool[position] = [@sample]
      else
        @ai_guess_pool[position] -= [@sample]
      end
    end
  end

  def check_game_end_ai
     if @current_guess == @answer
       draw_board("Opponent's")
       puts "You lose! The Computer cracked your secret code!"
       @game_over = true    
     elsif @turn > @total_turns
       draw_board("Opponent's")
       puts "You win! The Computer didn't crack your secret code of #{@answer.join(" ")}."
       @game_over = true
     end
  end
end

a = MasterMind.new
