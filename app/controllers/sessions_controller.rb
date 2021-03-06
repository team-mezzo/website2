class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
  end

  def create
  	user = Stakeholder.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		# log user in and redirect to user's donations page
  		log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user) # remember me checkbox
  		redirect_back_or donations_path # redirect to the page they were trying to access or (default) to their profile
  	else
  		flash.now[:danger] = 'Invalid email/password combination' # flash notice error message
    		render 'new' # try log in again
  	end
  end

  def destroy
  	log_out if logged_in? # to prevent log out confusion on multiple browser tabs
  	redirect_to login_path
  end

  private
    def redirect_if_logged_in
      if logged_in?
        redirect_to donations_path
      end
    end
end
