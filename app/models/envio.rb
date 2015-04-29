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
	belongs_to :user 
	validates :idUser, :presence => true
	default_scope {order('envios.created_at DESC')}
end
