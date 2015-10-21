class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :blurb
      t.integer :status_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
