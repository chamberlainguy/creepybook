class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :surname
      t.string :email
      t.text :pic
      t.text :password_digest

      t.timestamps null: false
    end

    add_index(:users, [:email], unique: true)
  end
end
