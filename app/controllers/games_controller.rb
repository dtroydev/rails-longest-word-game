require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split(' ')
    valid_letters = check_valid_letters
    valid_word = check_valid_word if valid_letters == true
    if valid_letters == false
      @error = "can't be built out of #{@letters.join(', ')}"
    end
    @error = 'does not seem to be a valid English word' if valid_word == false
    @score = @word.length if @error.nil?
  end

  private

  def check_valid_letters
    letters_hash = Hash.new(0)
    @letters.each do |letter|
      letters_hash[letter] += 1
    end
    @word.each_char do |letter|
      return false if !letters_hash.key?(letter) || letters_hash[letter].zero?

      letters_hash[letter] -= 1
    end
    true
  end

  def check_valid_word
    api = 'https://wagon-dictionary.herokuapp.com/'
    result = JSON.parse(URI.open("#{api}#{@word}").read)
    result['found']
  end
end
