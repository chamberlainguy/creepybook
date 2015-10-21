# == Schema Information
#
# Table name: statuses
#
#  id         :integer          not null, primary key
#  blurb      :text
#  likes      :integer
#  dislikes   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Status < ActiveRecord::Base

	belongs_to :ownedby_user, class_name: "User",
							foreign_key: "ownedbyuser_id"

    belongs_to :postedby_user, class_name: "User",
    					  foreign_key: "postedbyuser_id"		

	has_many :comments, :dependent => :destroy

	has_many :pictures, as: :imageable

end
