class ForInARow
  @@board = []
  @@rows = 6
  @@columns = 7
  @@move_counter = 0
  @@current_player = 1
  @@total_moves = 0
  @@playeronemoves = 0
  @@playertwomoves = 0

  def initialize(game)
      if game === "new" #Create new variables and start new game
          puts 'Welcome to Four in a Row!'
          @board = empty_board()
          @rows = @board[1].length
          @columns = @board.length
          @move_counter = 0
          @current_player = 1
          @total_moves = 0
          @playeronemoves = Array.new()
          @playertwomoves = Array.new()
      else
          raise ArgumentError, "Invalid game: #{game}"       
      end
  end
    
  def empty_board
    rows, columns = nil, nil
    
    system("clear") || system("cls") # Clear the console screen
    
      print 'Enter board height (min 6): '
      rows = gets.chomp.to_i
    
      print 'Enter board width (min 7): '
      columns = gets.chomp.to_i
    
      while !(rows >= 6 && columns >= 7) || (columns - rows).abs > 2
        puts "Invalid board dimensions. Please try again."
        gets.chomp # Pause for user to read the message
    
        system("clear") || system("cls") # Clear the console screen
    
        print 'Enter board height (min 6): '
        rows = gets.chomp.to_i
    
        print 'Enter board width (min 7): '
        columns = gets.chomp.to_i
      end
    
      board = Array.new(columns) { Array.new(rows) { 0 } }
      return board
  end
  
  def print_board # printing the Board
    row_separator = "+---" * @columns + "+"
  
    puts row_separator
  
    @rows.times do |i|
      print "|"
      @columns.times do |j|
        symbol = case @board[j][i]
                 when 0 then " - "
                 when 1 then " X "
                 when 2 then " O "
                 end
        print symbol + "|"
      end
      puts "\n" + row_separator
    end
  
    column_numbers = (1..@columns).map { |n| n < 10 ? "#{n}." : "#{n}" }.join("  ")
    puts "  " + column_numbers
  
    puts "Move History:"
    puts "Player 1: #{@playeronemoves.join(', ')}"
    puts "Player 2: #{@playertwomoves.join(', ')}"
  end  

  def play
    selected_column = nil
    
    puts @rows
    puts @columns
    puts @move_counter
  
    while (@move_counter < @rows * @columns) do
      @move_counter = @move_counter + 1
      @total_moves += 1
  
      print_board()
      print " Now, Player: "+@current_player.to_s+" should take a move -> "
  
      while true 
        input = gets.chomp.downcase
        selected_column = input.to_i - 1
        if (selected_column.to_i >= 0 && selected_column.to_i < @columns)
          if(!full_column?(selected_column))
            update_column(selected_column, @current_player)
            break
          else
             puts("Please enter a valid column number:")
          
          end
        
        else
          puts("Invalid")
        end
      end
  
      if win_condition()
        puts "\e[H\e[2J"
        print_board()
        puts ("Player #{@current_player} wins!")
        break 
      end

      if (@current_player == 1)
        @playeronemoves.append(selected_column + 1)
      else
        @playertwomoves.append(selected_column + 1)
      end
  
      if @current_player == 1
        @current_player = 2
      elsif @current_player == 2
        @current_player = 1
      end
    end
  
    

    if (@total_moves == @rows * @columns)
      puts "\e[H\e[2J"
      print_board()
      puts ("The game is a draw! GGWP")
    end
  end  
  

  def update_column(index, symbol) #it will insert at first free space in colup from top to bottom
    column = @board[index]
    i = column.length - 1
    while (i > 0 && column[i] != 0)
      i -= 1
    end
    column[i] = symbol
  end

  def full_column?(index)
    column = @board[index]
    i=0
    while (i<column.length)
      if column[i]==0
        return false
      end
      i+=1
    end
  return true
  end

  def win_condition() # Check is there winner, this will check it by checking every direction, horizontal, vertical and diagonal
    return true if horizontal_win?() || vertical_win?() || diagonal_win?()
    return false
  end  

  def horizontal_win?
    @rows.times do |row| # current row
      (@columns - 3).times do |col| # current column 
        if row_win?(row, col)
          puts "Horizontal win detected at row #{row}, starting at column #{col}."
          return true
        end
      end
    end
    return false
  end
  
  def vertical_win?()
    (@columns - 3).times do |col|
      @rows.times do |row|
        return true if col_win?(row, col)
      end
    end
    return false
  end

  def diagonal_win?()
    (@columns - 3).times do |col| #similiar to for each
      (@rows - 3).times do |row|
        return true if diagonal_win_from_top_left?(row, col) || diagonal_win_from_top_right?(row, col)
      end
    end
    return false
  end

  def row_win?(row, col)
    return false unless col + 3 < @columns  # This line checks that there are right number of columns to check
    return @board[col][row] == @current_player &&
           @board[col + 1][row] == @current_player &&
           @board[col + 2][row] == @current_player &&
           @board[col + 3][row] == @current_player
  end
  

  def col_win?(row, col)
    return @board[col][row] == @current_player &&
           @board[col][row + 1] == @current_player &&
           @board[col][row + 2] == @current_player &&
           @board[col][row + 3] == @current_player
  end

  def diagonal_win_from_top_left?(row, col)
    return @board[col][row] == @current_player &&
           @board[col + 1][row + 1] == @current_player &&
           @board[col + 2][row + 2] == @current_player &&
           @board[col + 3][row + 3] == @current_player
  end

  def diagonal_win_from_top_right?(row, col)
    return @board[col][row + 3] == @current_player &&
           @board[col + 1][row + 2] == @current_player &&
           @board[col + 2][row + 1] == @current_player &&
           @board[col + 3][row] == @current_player
  end
    
end

while true
  board1=ForInARow.new("new")
  board1.play()
  puts("Do you want to play again? yes/anything else for no")
  if(gets.chomp.downcase != "yes")
    break
  end
end