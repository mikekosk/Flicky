class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.integer :score
      t.string :movie
      t.string :viewer
      t.string :star
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
