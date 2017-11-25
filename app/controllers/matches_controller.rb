class MatchesController < ApplicationController
  before_action :authenticate_user!
  def index
    @categories = Category.all    

    @all_time = User.all.sort { |x, y| y.adjusted_total_points <=> x.adjusted_total_points }
  end

  def new
    @users = User.where.not(id: current_user.id)
    @match = Match.new
    @category = Category.find(params[:category_id])
    @game_count = @category.game_count

    @opponent = User.find(params[:opponent]) if params[:opponent]
  end

  def create
    @match = Match.new(match_params)
    @opponent = User.find(params[:match][:opponent])

    if @match.save!
      create_participants
      @match.games.each{ |game| game.update_attribute(:loser, resolve_game_loser(game)) }
      resolve_match_winner
      redirect_to matches_path
    else
      render :new
    end
  end

  private 

  def match_params
    params.require(:match).permit(:category_id, :opponent, games_attributes: [:id, :winner, :loser])
  end

  def resolve_game_loser(game)
    game.winner == current_user.id ? @opponent.id : current_user.id
  end

  def resolve_match_winner
    if current_user_is_winner
      winner, loser = current_user.id, @opponent.id
    else
      winner, loser = @opponent.id, current_user.id
    end

    @match.update_attribute(:winner, winner)
    @match.update_attribute(:loser, loser)
  end

  def current_user_is_winner
    @match.games.where(winner: current_user.id).size > @match.games.where(winner: @opponent.id).size
  end

  def create_participants
    Participant.create(user_id: current_user.id, match_id: @match.id)
    Participant.create(user_id: @opponent.id, match_id: @match.id)
  end
end
