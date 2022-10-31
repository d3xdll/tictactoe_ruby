class Game

@@winning_numbers = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

  def initialize
    p "Enter your name"
    @new_player1 = Player.new
    @new_player2 = Opponent.new
    create_board
    gaming
  end

  def create_board
    @gaming_board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    @gaming_board.each { |n| p n }
    @player1_marks = []
    @player2_marks = []
  end

  def mark(player, mark, number)
    if @player1_marks.include?(number) || @player2_marks.include?(number)
      puts "Sorry you're skipping your move"
    else
      @gaming_board.map! do |n|
        if n.include?(number)
          player.push(number)
          n.map! { |num| num == number ? mark : num }
        else
          n
        end
      end
      player.sort!
      @gaming_board.each { |n| p n }
    end
  end

  def gaming
    loop do
      @player1_num = @new_player1.choose_num
      mark(@player1_marks, @new_player1.mark, @player1_num)
      if win?(@player1_marks)
        puts "You've won #{@new_player1.name}"
        break
      end
      if tie?
        puts "It's a tie"
        break
      end
      
      
      @player2_num = @new_player2.choose_opp_num
      mark(@player2_marks, @new_player2.mark, @player2_num)
      if win?(@player2_marks)
        puts "You've won #{@new_player2.name}"
        break
      end
      if tie?
        puts "It's a tie"
        break
      end
    end
  end

  def win?(players_num)
    check=@@winning_numbers.map do |arr|
      (arr-players_num).empty?
    end
    check.one?(true)
  end

  def tie?
    @gaming_board.flatten.all? { |i| i.is_a?(Integer) }
  end
end

class Player
  attr_accessor :num, :mark, :name

  def initialize
    @name = gets.chomp
    @mark = "X"
    puts "Welcome #{@name}, your mark is #{@mark}"
  end

  def choose_num
    print "Make your move\n"
    @num = gets.chomp
    print "Your move is #{@num}\n"
    @num.to_i
  end
end

class Opponent
attr_accessor :mark, :name

  def initialize
    @name = Opponent.choose_name
    @mark = "O"
  end

  def self.choose_name
    @name_array = ["Stan", "Snow", "Gary", "Aldrige", "Jonh"]
    @name = @name_array.sample
  end

  def choose_opp_num
    puts "Now it's my move"
    [1, 2, 3, 4, 5, 6, 7, 8, 9].sample
  end

end

Game.new