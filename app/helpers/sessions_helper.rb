module SessionsHelper
	# logs in a given user and remembers her user id
	def log_in(user)
		session[:stakeholder_id] = user.id
	end

	# returns the current logged-in user (if any)
	def current_user
		@current_user ||= Stakeholder.find_by(id: session[:stakeholder_id])
	end

	# returns true if user is logged in, false otherwise
	def logged_in?
		!current_user.nil?
	end

	# logs out given user and resets current user to nil
	def log_out
		session.delete(:stakeholder_id)
		@current_user = nil
	end
end
