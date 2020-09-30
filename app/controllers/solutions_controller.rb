class SolutionsController < ApplicationController
  def show
    @party = Party.find(params[:party_id])

    find_all_the_solutions(@party)

    @solutions = Solution.where(party_id: @party)
  end

  private

  def find_all_the_solutions(party)
    dictionnaire = File.read(Rails.root.join('public', 'liste_francais.txt')).split("\n")

    dictionnaire.each do |word|
      intersect = word.split("") & party.ten_letters_list.split
      if intersect.length == word.length
        Solution.create!(word: word, party: party)
      end
    end


  end
end
