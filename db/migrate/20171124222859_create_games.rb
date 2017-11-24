class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :winner
      t.integer :loser

      t.timestamps
    end
  end
end
