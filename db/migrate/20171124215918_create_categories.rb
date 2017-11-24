class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :loss
      t.integer :win
      t.integer :victory

      t.timestamps
    end
  end
end
