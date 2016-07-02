class HangpersonGame
  attr_accessor :word, 
                :guesses, 
                :wrong_guesses,
                :word_with_guesses,
                :check_win_or_lose
  
  def initialize(word)
    #Variables públicas (aparecen en el attr accesor)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = @word.gsub(/\w/,'-')
    @check_win_or_lose = :play
    #Variables privadas
    @attempts = 0
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(character)
    
    #Se asegura que no existan casos invalidos
    if(character == '' || character =~ /\W/ || character == nil)
+      raise(ArgumentError, 'Should be a character not empty')
    end
    
    #expresion regular para comparar la letra ingresada
    check_regex = /#{character}/i
    
    #Se asegura que la letra ingresada no sea repetida
    if(@guesses !~ check_regex && @wrong_guesses !~ check_regex)
      
      #nuevo intento
      @attempts += 1
      
      #Caso correcto
      if(@word =~ check_regex)
        
        @guesses += character
 
        #Hacemos una sustitución con los caracteres acertados
        @word_with_guesses = @word.gsub(/[^#{@guesses}]/i, '-')
        
        #Comparamos si la palabra con las letras acertadas esta completa
        if(@word_with_guesses == @word)
          @check_win_or_lose = :win
        end
        
      #Caso incorrecto
      else
        
        if(@attempts >= 7)
          @check_win_or_lose = :lose
        end
        
        @wrong_guesses += character
      end
    else
      return false
    end
    return true
  end

end