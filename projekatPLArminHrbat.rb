class ForInARow
  @@board = []
  @@rows = 6
  @@columns = 7
  

  def initialize(game)
      if game === "new" #Create new variables and start new game
          puts 'Welcome to Four in a Row!'
          @board = empty_board()
          @rows = @board[1].length
          @columns = @board.length
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
    
end
