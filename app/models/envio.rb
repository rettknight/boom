# == Schema Information
#
# Table name: envios
#
#  id           :integer          not null, primary key
#  status       :integer          not null
#  date         :datetime         not null
#  reference    :string(100)      not null
#  origin       :string(100)      not null
#  destiny      :string(100)      not null
#  department   :string(100)      not null
#  comments     :string(255)      not null
#  user_id      :integer          not null
#  transport_id :integer
#  detail_id    :integer
#

class Envio < ActiveRecord::Base
	belongs_to :user, foreign_key: "user_id"
	validates :user_id, :presence => true
	default_scope {order('envios.created_at DESC')}
end
