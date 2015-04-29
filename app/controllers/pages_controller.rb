class PagesController < ApplicationController
  def home
  	@title = " - Home"
  	if signed_in?
  		@envio = Envio.new
  	end
  end
end

# user from user.rb model, .feed is obtained by creating a new 'def' method