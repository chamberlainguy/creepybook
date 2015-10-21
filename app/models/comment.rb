# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  blurb      :text
#  status_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base

	belongs_to :status

	belongs_to :user

end
