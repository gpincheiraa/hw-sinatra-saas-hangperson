class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses, :check_win_or_lose
  
  def initialize(word, guesses='', wrong_guesses='')
    @word = word
    @guesses = guesses
    @wrong_guesses = wrong_guesses
    @word_with_guesses = @word.gsub(/\w/,'-')
    @attempts = 0
    @check_win_or_lose = :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  def guess(character)
    
    if(character == '' || character =~ /\W/ || character == nil)
      raise(ArgumentError, "Should be a character not empty")
    end
    
    @attempts += 1
    
    character = character.downcase
    valid = @word.index(character) != nil && @guesses != character
    
    if(valid)
      @guesses = character
      
      @word.each_char.with_index do |char, index|
        if(char == character)
          @word_with_guesses[index] = char
        end
      end
      
      if(@word_with_guesses == @word)
         @check_win_or_lose = :win
      end
      
      return true
    else
      @wrong_guesses = character
      
      if(@attempts == 7)
        @check_win_or_lose = :lose
      end
      return false
    end
    
    
    
  end
  
  
  
end
