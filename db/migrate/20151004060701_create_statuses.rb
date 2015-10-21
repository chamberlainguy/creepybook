class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.text :blurb
      t.integer :likes
      t.integer :dislikes
      t.integer :ownedbyuser_id
	  t.integer :postedbyuser_id
      
      t.timestamps null: false
    end
  end
end
