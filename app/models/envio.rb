# == Schema Information
#
# Table name: envios
#
#  idEnvio     :integer          not null, primary key
#  status      :integer          not null
#  date        :datetime         not null
#  reference   :string(100)      not null
#  origin      :string(100)      not null
#  destiny     :string(100)      not null
#  department  :string(100)      not null
#  comments    :string(255)      not null
#  idUser      :integer          not null
#  idTransport :integer          not null
#  idDetail    :integer          not null
#

class Envio < ActiveRecord::Base
	belongs_to :user #association to user model

	validates :content, :presence => true
	validates :idUser, :presence => true
	
	default_scope {order('envios.created_at DESC')}
	scope :from_users_followed_by, lambda {|user| followed_by(user)}
	#scope generates a method called from_users_followed_by
	#that is called in the user.rb model by the feed method. 
	private
		def self.followed_by(user)
		followed_ids = %(SELECT followed_id FROM relationships 
					     WHERE follower_id = :idUser) #SQL 
		where("idUser IN (#{followed_ids}) OR idUser = :idUser", :idUser=> user)
			#to convert into SQL for parameter
		end
end
