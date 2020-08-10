require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('a'..'z').to_a.sample }
    return @letters
  end

  def score
    # binding.pry
    # raise
    @word = params[:word]

    if english?(@word) == false
      @result = "Sorry but #{@word} does not seem to be a valid English word"
    elsif comparison?(@word) == false
      @result = "Sorry but #{@word} can't be built out of #{@letters}"
    else
      @result = "CONGRATULATIONS! #{@word} is a valid English word!"
    end
  end

  private

  def english?(word)
    dico_serialized = open("https://wagon-dictionary.herokuapp.com/#{word}").read
    dico = JSON.parse(dico_serialized)
    dico['found']
  end

  def comparison?(word)
    @letters = params[:letters].downcase.split
    @word_array = params[:word].downcase.chars.all? do |letter|
      @letters.include?(letter)
    end
  end
end
