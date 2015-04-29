class PagesController < ApplicationController
  def home
  	@title = " - Home"
  	@envio = Envio.new if signed_in? 
  end
end
