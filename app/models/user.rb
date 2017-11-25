class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def wins
    Match.where(winner: self.id).size
  end

  def loses
    Match.joins(:participants).where(participants: {user_id: self.id}).where.not(winner: self.id).size
  end

  def matches_played
    Participant.where(user_id: self.id).size
  end

  def total_points
    arr = []
    Match.joins(:participants).where(participants: {user_id: self.id} ).each do |match|
      if match.winner == self.id
        arr << match.category.victory
      end
      match.games.each do |game|
        if game.winner == self.id
          arr << game.match.category.win
        elsif game.winner == 
          arr << game.match.category.loss
        end
      end
    end
    arr.inject(0){|sum,x| sum + x }
  end

  def adjusted_total_points
    if self.total_points == 0 || self.matches_played == 0
      0
    else
      self.total_points / self.matches_played
    end
  end
end
