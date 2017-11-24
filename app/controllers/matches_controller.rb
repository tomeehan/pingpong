class MatchesController < ApplicationController
  def index
    @categories = Category.all    
  end

  def new
    @users = User.where.not(id: current_user.id)
    @match = Match.new
    @category = Category.find(params[:category_id])

    if params[:opponent]
      @opponent = User.find(params[:opponent])
    end
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
