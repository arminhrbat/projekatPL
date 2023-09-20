class ForInARow
  @@board = []
  @@rows = 6
  @@columns = 7
  @@move_counter = 0
  @@current_player = 1
  @@total_moves = 0


  def initialize(game)
      if game === "new" #Create new variables and start new game
          puts 'Welcome to Four in a Row!'
          @board = empty_board()
          @rows = @board[1].length
          @columns = @board.length
          @move_counter = 0
          @current_player = 1
          @total_moves = 0
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

  # printing the Board
  def print_board
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
  end  

  def play
    puts @rows
    puts @columns
    puts @move_counter
    while (@move_counter < @rows * @columns) do
      @move_counter = @move_counter + 1
      @total_moves += 1
  
      print_board()
      print " Now, Player: "+@current_player.to_s+" should take a move"
  
      loop do
        input = gets.chomp.downcase
        selected_column = input.to_i - 1
        if (selected_column.to_i >= 0 && selected_column.to_i < @columns)
          if update_column(@board[selected_column], @current_player)
            break
          else
            puts("Column is full. Please choose another column:")
          end
        else
          puts("Please enter a valid column number:")
        end
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
      puts ("There is no empty fields anymore, this is THE END!")
    end
  end
  

  def update_column(column, symbol)
    i = column.length - 1
    while (i > 0 && column[i] != 0)
      i -= 1
    end
    column[i] = symbol
  end
    
end

