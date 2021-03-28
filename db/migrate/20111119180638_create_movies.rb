class CreateMovies < ActiveRecord::Migration
  def up
    create_table :stores do |t|
      t.string :name
      t.string :rating
      t.string :category
      t.text :description
      t.string :menu
      t.string :image
     
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
    end
      
    create_table :orders do |t|
      t.string :name
      t.string :image
      t.string :item
      t.string :deliver_to
      t.string :user_id
      t.string :status
     
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
    end
  end

  def down
    drop_table :stores
    drop_table :orders
  end
end
