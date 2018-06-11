require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(3)
end

def score
    @guess = params[:try]
    @grid = params[:letters]
    if included?(@guess.upcase, @grid)
        if english_word?(@guess)
            @result =[score,"well done u baboon"]
        else
           @result = [0,"This is no Engrish Word u Baboon"] 
       end 
   else 
    @result = [0,"Use the Letters u Baboon"] 
end
end

def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
end


def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
end

def compute_score(attempt, time_taken)
    time_taken > 60.0 ? 0 : attempt.size * (1.0 - time_taken / 60.0)
end

end
