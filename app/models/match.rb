class Match < ApplicationRecord
  has_many :games 
  accepts_nested_attributes_for :games, reject_if: :all_blank, allow_destroy: true
end
