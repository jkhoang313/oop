class TicTacToe
  @win = false

  def initialize
    puts "What is the first player's name?" 
    @first_player = gets.chomp
    puts "What is the second player's name?"
    @second_player = gets.chomp

    @board = Array.new(3) {Array.new(3)}   
    new_game
  end
 


  def draw_board
    @board.each_with_index do |row, row_index| 
      unless row == @board[2]
	print row.join("_|")
        print "_" 
      else
        print row.join(" |")
      end

      print "\n"
     end
  end

  def new_game
    @board.each_with_index do |row, row_index|
      row.each_with_index do |position, column_index|
        @board[row_index][column_index] = row_index * 3 + column_index + 1
      end
    end

    p1_turn
  end

  def p1_turn
    draw_board
    @moved = false
    puts "#{@first_player}, choose your spot"
    choice = gets.chomp.to_i
    
    @board.each_with_index do |row, row_index|
      row.each_with_index do |position, column_index|
        if position == choice
	  @board[row_index][column_index] = "X"
          @moved = true
	end
      end
    end
   
    if @moved == true
      p1_win
      p2_turn unless @win == true
    else 
      puts "Make a valid move!"
      p1_turn
    end
  end

  def p2_turn
    draw_board
    @moved = false
    puts "#{@second_player}, choose your spot"
    choice = gets.chomp.to_i
    
    @board.each_with_index do |row, row_index|
      row.each_with_index do |position, column_index|
        if position == choice
	  @board[row_index][column_index] = "O"
          @moved = true
	end
      end
    end
   
    if @moved == true
      p2_win
      p1_turn unless @win == true
    else 
      puts "Make a valid move!"
      p2_turn
    end
  end

  def p1_win
    row_win
    column_win
    diag_win
    if @win == true
      draw_board
      puts "#{@first_player} wins!"
    end 
  end

  def p2_win
    row_win
    column_win
    diag_win
    
    if @win == true
      draw_board
      puts "#{@second_player} wins!"
    end      
  end

  def row_win
    if @board[0][0] == @board[0][1] && @board[0][1] == @board[0][2]
      @win = true
    end      
    if @board[1][0] == @board[1][1] && @board[1][1] == @board[1][2]
      @win = true
    end 
    if @board[2][0] == @board[2][1] && @board[2][1] == @board[2][2]
      @win = true
    end 
  end

  def column_win
    if @board[0][0] == @board[1][0] && @board[1][0] == @board[2][0]
      @win = true
    end      
    if @board[0][1] == @board[1][1] && @board[1][1] == @board[2][1]
      @win = true
    end 
    if @board[0][2] == @board[1][2] && @board[1][2] == @board[2][2]
      @win = true
    end 
  end

  def diag_win
    if @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2]
      @win = true
    end      
    if @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0]
      @win = true
    end 
  end
end

a = TicTacToe.new
