class EnviosController < ApplicationController
	before_filter :authenticate
	def create
	 @envio = current_user.envios.build(params[:envio])
	 if @envio.save
	 	redirect_to root_path, :flash => {:success => "Envio created"}
	 else
	 	render 'pages/home'
	 end
	end
	def destroy
		
	end
	
	private
		def authenticate
			deny_access unless signed_in?
		end
end
