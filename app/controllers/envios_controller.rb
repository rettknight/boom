	class EnviosController < ApplicationController
	before_filter :authenticate
	before_filter :authorized_user, :only => :destroy 
	def create
	 @envio = current_user.envios.build(envio_params)
	 if @envio.save
	 	redirect_to root_path, :flash => {:success => "Envio created. "}
	 else
	  	render 'pages/home'
	 end
	end
	def destroy
	 @envio.destroy
	 redirect_to root_path, :flash => {:success => "Envio deleted. "}
	end
	private
		def authenticate
			deny_access unless signed_in?
		end
		def envio_params
			params.require(:envio).permit(:status, :reference, :origin, :destiny, :department, :comments)
		end
		def authorized_user
			@envio = Envio.find(params[:id])
			redirect_to root_path unless current_user?(@envio.user)
		end
end