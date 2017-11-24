class AddMatchIdToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :match_id, :integer
  end
end
