class MatchesController < ApplicationController
  def index
    @categories = Category.all    
  end

  def new
    @users = User.where.not(id: current_user.id)
    @match = Match.new
    @category = Category.find(params[:category_id])

    @opponent = User.find(params[:opponent]) if params[:opponent]
  end

  def create
    @match = Match.new(match_params)
    @opponent = User.find(params[:match][:opponent])

    if @match.save!
      create_participants
      @match.games.each{ |game| game.update_attribute(:loser, resolve_loser(game)) }
      redirect_to matches_path
    else
      render :new
    end
  end

  private 

  def match_params
    params.require(:match).permit(:category_id, :opponent, games_attributes: [:id, :winner, :loser])
  end

  def resolve_loser(game)
    game.winner == current_user.id ? @opponent.id : current_user.id
  end

  def create_participants
    Participant.create(user_id: current_user.id, match_id: @match.id)
    Participant.create(user_id: @opponent.id, match_id: @match.id)
  end
end
