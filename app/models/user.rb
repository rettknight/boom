# == Schema Information
#
# Table name: users
#
#  idUser             :integer          not null, primary key
#  name               :string(100)      not null
#  lastname           :string(100)
#  email              :string(100)      not null
#  encrypted_password :string(255)      not null
#  salt               :string(200)
#  updatedAt          :datetime         not null
#  createdAt          :datetime         not null
#  deletedAt          :datetime
#  lastConnection     :datetime         not null
#  rfc                :string(255)
#  curp               :string(255)
#  avatar             :string(255)
#  admin              :boolean          default(FALSE)
#
class User < ActiveRecord::Base
	attr_accessor :password
	has_many :envios
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, :presence => true, 
					 :length   => {:maximum => 50} 
	validates :email, :presence => true, 
					  :format   => {:with => email_regex},
					  :uniqueness => {:case_sensitive => false}
	validates :password, :presence => true,
						 :confirmation => true,
						 :length => {:within => 6..30} 
	before_save :encrypt_password
	def has_password?(submitted_password)
	  encrypted_password == encrypt(submitted_password)	
	end
	class << self
		def authenticate(email, submitted_password)
			user = find_by_email(email) 
			(user && user.has_password?(submitted_password)) ? user : nil
		end
		def authenticate_with_salt(id, cookie_salt)
			user = find_by_idUser(id)
			(user && user.salt == cookie_salt) ? user : nil 
		end
	end
	private	
		def encrypt_password
			self.salt = make_salt if new_record? 
			self.encrypted_password = encrypt(password)
		end

		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end

		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end

		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end
end
