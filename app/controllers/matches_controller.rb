class MatchesController < ApplicationController
  def index
    @categories = Category.all    
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)

    if @match.save!
      redirect_to matches_path
    else
      render :new
    end
  end

  private 

  def match_params
    params.require(:match).permit(:category_id, games_attributes: [:id, :winner, :loser])
  end
end
