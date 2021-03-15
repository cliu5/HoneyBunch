class CreateMovies < ActiveRecord::Migration
  def up
    create_table :stores do |t|
      t.string :name
      t.string :rating
      t.text :description
      t.string :menu
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
    end
  end

  def down
    drop_table :stores
  end
end
