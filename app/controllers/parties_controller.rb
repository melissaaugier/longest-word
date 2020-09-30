class PartiesController < ApplicationController
  def new
    @game = Game.find(params[:game_id])
    @party = Party.new
    vowels = ["a", "e", "i", "o", "u"]
    consonants = (('a'..'z').to_a - 'aeiou'.chars)

    @ten_letters_list = []
    5.times do
      @ten_letters_list << vowels.sample
      @ten_letters_list << consonants.sample
    end
  end

  def create
    @party = Party.new(party_params)
    @game = Game.find(params[:game_id])
    @party.game = @game
    @party.available = @party.is_french?

    if made_with_letters?(@party) && @party.is_french? && @party.save
      redirect_to game_party_solution_path(id: @game, party_id: @party)
    else
      @ten_letters_list = params[:party][:ten_letters_list].split
      render :new
    end
  end

  private

  def party_params
    params.require(:party).permit(:ten_letters_list, :word, :available)
  end

  def made_with_letters?(party)
    intersect = party.ten_letters_list.split("") & party.word.split("")
    intersect.length == party.word.length
  end
end
