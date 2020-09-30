class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.new(user: current_user)
    @game.save
    redirect_to new_game_party_path(@game)
  end
end
