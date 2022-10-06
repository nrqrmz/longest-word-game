require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { (('a'..'z').to_a).sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(' ')
    @valid = valid_word?(@word, @letters)
    @english = english_word?(@word)
  end

  private

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    JSON.parse(URI.open(url).read)['found']
  end

  def valid_word?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end
end
