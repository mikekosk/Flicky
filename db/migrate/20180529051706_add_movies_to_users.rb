class AddMoviesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :movies, :text
  end
end
