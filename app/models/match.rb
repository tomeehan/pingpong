class Match < ApplicationRecord
  belongs_to :category
  
  has_many :games 
  has_many :participants
  accepts_nested_attributes_for :games, reject_if: :all_blank, allow_destroy: true

  attr_accessor :opponent
end
