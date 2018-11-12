class HangpersonGame
  # For representing a hang person game
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  attr_reader :word
  attr_reader :guesses
  attr_reader :wrong_guesses

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
