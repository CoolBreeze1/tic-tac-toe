module TicTacToe

  class Player
    attr_accessor :name, :piece
    def initialize(name, piece)
      @name = name
      @piece = piece
    end

  end

  class GameLoop
    attr_accessor :board, :play_counter
    def initialize
      @board = GameBoard.new
      @play_counter = 0
    end

    def start_game
      welcome
      player_info

      loop do
        board.display_board
        good_move = false
        until good_move
          move = player_move
          if valid_move?(move)
            good_move = true
            board.data[move-1] = @current_player.piece
          else
            puts "Sorry that wasn't a valid move"
          end
        end
        @play_counter += 1
        if winner?
          puts "#{@current_player.name} is the winner"
          board.display_board
          break
        end
        if draw?
          puts "It's a draw."
          board.display_board
          break
        end
        switch_player
      end
    end

    def welcome
    puts "*********************************"
    puts "     Welcome to TicTacToe!    "
    puts " Place 3 markers in a row to win."
    puts "   They can be placed vertical,   "
    puts "    horizontal or diagonal.     "
    puts "          Lets Play!            "
    puts "*********************************"

    puts "                                 "

    puts " The board is displayed as so -"

    puts "                                "

    puts "      '1'     |      '2'     |    '3'    "
    puts " ----------------------------------------"
    puts "      '4'     |      '5'     |    '6'    "
    puts " ----------------------------------------"
    puts "      '7'     |      '8'     |    '9'    "

    puts "                                "

    puts "The numbers are a reference to a location on the board "
     puts "                                "
     puts " OK! Lets Play! "
    end



    @@winning_combo = [[0,1,2], [3,4,5], [6,7,8],
                        [0,3,6], [1,4,7], [2,5,8],
                        [6,4,2], [0,4,8]]

    def player_move
      puts "Ok #{@current_player.name}, please enter number where you want to place your mark: "
      move = gets.chomp.to_i
      move
    end

    def winner?
      @@winning_combo.any? do |combo|
        combo.all? {|num| board.data[num] == @current_player.piece }

      end

    end

    def draw?
      if @play_counter > 8
        true
      else
        false
      end
    end

    def valid_move?(move)
      board.data.include?(move)
    end



    #take input from Player
    def player_info
      puts "Player 1, please enter your name: "
      @player1_name = gets.chomp
      puts " #{@player1_name} your marker is X"
      @player1_sym = "X"


      puts "Player 2, please enter your name: "
      @player2_name = gets.chomp
      puts " #{@player2_name} your marker is O"
      @player2_sym = "O"

      @player1 = Player.new(@player1_name, @player1_sym)
      @player2 = Player.new(@player2_name, @player2_sym)
      @current_player = @player1
    end

    def switch_player
      if @current_player == @player1
        @current_player = @player2
      else
        @current_player = @player1
      end
    end


  end

  class GameBoard
    attr_accessor :data

    def initialize
      @data = [1,2,3,4,5,6,7,8,9]
    end

      def display_board
      puts " #{@data[0]} | #{@data[1]} | #{@data[2]} "
      puts " ----------"
      puts " #{@data[3]} | #{@data[4]} | #{@data[5]} "
      puts " ----------"
      puts " #{@data[6]} | #{@data[7]} | #{@data[8]} "
      end

  end
end

board = TicTacToe::GameLoop.new
board.start_game
