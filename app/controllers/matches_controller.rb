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
    @opponent = User.find(params[:match][:opponent])

    if @match.save!
      @match.games.each{ |game| game.update_attribute(:loser, resole_loser(game)) }
      redirect_to matches_path
    else
      render :new
    end
  end

  private 

  def match_params
    params.require(:match).permit(:category_id, :opponent, games_attributes: [:id, :winner, :loser])
  end

  def resole_loser(game)
    game.winner == current_user.id ? @opponent.id : current_user.id
  end

end
