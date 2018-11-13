# For representing a hang person game
class HangpersonGame
  attr_reader :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # To process a guessed letter
  def guess(letter)
    unless (letter.is_a? String) && (letter.match /^[[:alpha:]]{1}$/)
      # The argument is not a letter
      raise ArgumentError, 'The argument is not a letter.'
    end

    # Add support for case insensitivity
    letter = letter.downcase
    if (guesses.include? letter) || (wrong_guesses.include? letter)
      # The letter is a repeated guess
      return false
    end

    if word.include? letter
      guesses << letter
    else
      wrong_guesses << letter
    end

    true
  end

  def word_with_guesses
    hidden_letter_match_pattern =
        guesses.empty? ? /./ : Regexp.new('[^' + guesses + ']')
    word.gsub(hidden_letter_match_pattern, '-')
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
