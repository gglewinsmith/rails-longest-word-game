class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score

    retrieved_word = params["Word"]
    retrieved_letters = params["letters"].upcase.split("")
    if match_words?(retrieved_word, retrieved_letters) && english_word?(retrieved_word)
      score = retrieved_word.length
    else
      score = 0
    end
    @result = { score: score, message: message(match_words?(retrieved_word, retrieved_letters), english_word?(retrieved_word)) }


  end
end

require 'open-uri'
require 'json'

def english_word?(post)
  url = "https://wagon-dictionary.herokuapp.com/#{post}"
  user_serialized = open(url).read
  user = JSON.parse(user_serialized)
  return user["found"]
end

def match_words?(attempt, sample_grid)
  attempt.chars.all? do |letter|
    sample_grid.count(letter.upcase) >= attempt.upcase.chars.count(letter.upcase)
  end
end

def message(is_in_grid, is_english_word)
  return "well done" if is_in_grid && is_english_word
  return "not an english word" if is_in_grid && !is_english_word
  return "not in the grid" unless is_in_grid
end









