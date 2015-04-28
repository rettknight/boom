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

	default_scope :order => 'microposts.created_at DESC'
end