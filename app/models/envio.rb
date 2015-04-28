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
	
	default_scope :order => 'envios.created_at DESC'
end