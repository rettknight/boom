# == Schema Information
#
# Table name: envios
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Envio < ActiveRecord::Base
	belongs_to :user #association to user model

	validates :content, :presence => true
	validates :user_id, :presence => true
	
	default_scope {order('envios.created_at DESC')}
	scope :from_users_followed_by, lambda {|user| followed_by(user)}
	#scope generates a method called from_users_followed_by
	#that is called in the user.rb model by the feed method. 
	private
		def self.followed_by(user)
		followed_ids = %(SELECT followed_id FROM relationships 
					     WHERE follower_id = :user_id) #SQL 
		where("user_id IN (#{followed_ids}) OR user_id = :user_id", :user_id => user)
			#to convert into SQL for parameter
		end
end