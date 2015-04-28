module SessionsHelper
	
	def sign_in(user)
		cookies.permanent.signed[:remember_token] = [user.id, user.salt]
		current_user = user	
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= user_from_remember_token
		# ||= if current_user is nil it'll return user_from_remember_token
		# if it's true it'll return current_user
		# equivalent to @current_user = @current_user || user_from_remember_token
	end

	def signed_in?
		!current_user.nil? #returns true if the user is not (!) nil
	end

	def sign_out
		cookies.delete(:remember_token)
		current_user = nil 
	end


    def deny_access
		redirect_to signin_path, :notice => "Please sign in to access this page."
    end

	private
		def user_from_remember_token
			User.authenticate_with_salt(*remember_token)
			# It works because salt is madre from id + the password & that's what it validates
			# the * means user.id, user.salt, it's basically what is inside the hash
		end

		def remember_token
			cookies.signed[:remember_token] || [nil, nil]
			# If it doesn't exist, it returns empty id & salt
		end
end