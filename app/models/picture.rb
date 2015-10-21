# == Schema Information
#
# Table name: pictures
#
#  id             :integer          not null, primary key
#  url            :text
#  isprofilepic   :boolean
#  imageable_id   :integer
#  imageable_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Picture < ActiveRecord::Base

	belongs_to :imageable, polymorphic: true

end
