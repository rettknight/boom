# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
	attr_accessor :name, :email #getters & setters
	attr_accessible :name, :email

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	# .permit(:name, :email)
	validates :name, :presence => true, #has to be inserted
					 :length   => { :maximum = 50 } 

	validates :email, :presence => true, 
					  :format   => {:with => email_regex},
					  :uniqueness => {:case_sensitive => false}
end
