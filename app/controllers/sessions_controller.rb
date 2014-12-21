class SessionsController < ApplicationController
  def new
  end

  def create
  	user = Stakeholder.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		# log user in and redirect to user's donations page
  		log_in user
  		redirect_to user
	else 
		flash.now[:danger] = 'Invalid email/password combination' # flash notice error message
  		render 'new' # try log in again
	end
  end

  def destroy
  	log_out
  	redirect_to login_path
  end
end
