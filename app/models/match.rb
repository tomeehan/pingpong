class Match < ApplicationRecord
  belongs_to :category
  
  has_many :games 
  accepts_nested_attributes_for :games, reject_if: :all_blank, allow_destroy: true
end
