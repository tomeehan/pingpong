class MatchesController < ApplicationController
  def index
    @categories = Category.all    
  end
end
