class EnviosController < ApplicationController
	before_filter :authenticate
	before_filter :authorized_user, :only => :destroy 
	def create
	 @envio = current_user.envios.build(envio_params)
	 if @envio.save
	 	redirect_to root_path, :flash => {:success => "Envio created. "}
	 else
	 	@feed_items = current_user.feed.paginate(:page => params[:page]) 
	 	#if we render it without feed_items it crashes 'cause home has it and this doesn't
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
			params.require(:envio).permit(:content)
		end
		def authorized_user
			@envio = Envio.find(params[:id])
			redirect_to root_path unless current_user?(@envio.user)
		end
end