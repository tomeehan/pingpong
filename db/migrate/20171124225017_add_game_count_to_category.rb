class AddGameCountToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :game_count, :integer
  end
end
