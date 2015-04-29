# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean          default(FALSE)
#

class User < ActiveRecord::Base
	attr_accessor :password
	# attr_accessible :name, :email, :password, :password_confirmation 
	# attr_accessible required? 
	has_many :envios, :dependent => :destroy #association to the envio model for it to work 
	#dependent -> destroy means if user is deleted envio is too. 
	#what happens if user is deleted and envio is needed? 
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	# .permit(:name, :email)
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

	def feed
		Envio.where("user_id = ?", id)
	end
	#Always use ? to avoid sql injection, good habit, it means where and it's filled by the next param (id)
	

	#def feed == keeping for future reference
	 # envios #returns all 'envios' made by the current user 	
	#end

	class << self
		def authenticate(email, submitted_password)
			user = find_by_email(email)  #no need to use User.find, just find -class method
			(user && user.has_password?(submitted_password)) ? user : nil
			# top equivalent to commented code 
			# return nil if user.nil?
			# return user if user.has_password?(submitted_password)
		end
		def authenticate_with_salt(id, cookie_salt)
			user = find_by_id(id)
			(user && user.salt == cookie_salt) ? user : nil 
			# ? will return user if user exists & user's salt = cookie salt, else (:) it returns nil	
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
