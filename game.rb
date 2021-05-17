class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza", "chair", "music", "plain", "animal", "discord"]

  def Hangman.random_word
    DICTIONARY.sample 
  end

  def initialize
    @random_word = Hangman.random_word
    @secret_word = @random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses 
    @remaining_incorrect_guesses
  end 

  def already_attempted?(char)
    if @attempted_chars.include?(char) == true 
      true 
    else 
      false 
    end
  end

  def get_matching_indices(char)
    arr = []
    if @secret_word.include?(char)
      @secret_word.each_char.with_index do |el, i|
        if el == char 
          arr << i
        end 
      end 
    end 
    arr
  end

  def fill_indices(char, arr)
    arr.each do |i|
      @guess_word[i] = char 
    end
  end

  def try_guess(char)
    if already_attempted?(char) == true 
      puts "that has already been attempted"
      false 
    else 
      @attempted_chars << char  
      if get_matching_indices(char).length == 0 
        @remaining_incorrect_guesses -= 1
      else    
        fill_indices(char, get_matching_indices(char))
      end
      true 
    end
  end

  def ask_user_for_guess
    puts "Enter a char"
    guess = gets.chomp 
    try_guess(guess)
  end

  def win? 
    if @guess_word.join("") == @random_word
      puts "WIN"
      true 
    else
      false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0 
      puts "LOSE"
      true 
    else
      false 
    end
  end

  def game_over?
    if win? == true || lose? == true 
      puts "the word was " + @secret_word
      true 
    else 
      false 
    end 
  end

end
hangman = Hangman.new

until hangman.game_over?
  puts "Incorrect Guesses Remaining: #{hangman.remaining_incorrect_guesses}"
  puts "Attempted Chars: #{hangman.attempted_chars}"
  puts "Word: #{hangman.guess_word}"
  print "\n" until hangman.ask_user_for_guess
  print "\n\n"
end
