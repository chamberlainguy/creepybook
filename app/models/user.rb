# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  firstname       :string
#  surname         :string
#  email           :string
#  password_digest :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base

	has_secure_password

	has_many :ownedby_statuses, class_name: "Status",
						  foreign_key: "ownedbyuser_id"

	has_many :postedby_statuses, class_name: "Status",
    					  foreign_key: "postedbyuser_id"

	has_many :comments

	has_many :pictures, as: :imageable
	
	has_and_belongs_to_many :friends, 
              class_name: "User", 
              join_table: :friendships, 
              foreign_key: :user_id, 
              association_foreign_key: :friend_user_id

    def fullname
    	firstname + ' ' + surname
    end          

end
