module SessionsHelper
	# logs in a given user and remembers her user id
	def log_in(user)
		session[:stakeholder_id] = user.id
	end

	# remembers a user in a persistent session
	def remember(user)
		user.remember # creates new remember token and stores encrypted version in remember digest
		cookies.permanent.signed[:stakeholder_id] = user.id # store encrypted user id
		cookies.permanent[:remember_token] = user.remember_token # store new token
	end

	# forgets a persistent session (for use when logging out)
	def forget(user)
		user.forget # empty password digest column

		# empty cookies
		cookies.delete(:stakeholder_id)
		cookies.delete(:remember_token)
	end

	# returns the current logged-in user or user corresponding to the remember token cookie
	def current_user
		if (user_id = session[:stakeholder_id]) # from current session
			@current_user ||= Stakeholder.find_by(id: user_id)
		elsif (user_id = cookies.signed[:stakeholder_id]) # from remember token cookies
			user = Stakeholder.find_by(id: user_id)
			if user && user.authenticated?(cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end

	# returns true if the given user is the current user. for authentication
	def current_user?(user)
		user == current_user
	end

	# returns true if user is logged in, false otherwise
	def logged_in?
		!current_user.nil?
	end

	# logs out given user and resets current user to nil
	def log_out
		forget(current_user)
		session.delete(:stakeholder_id)
		@current_user = nil
	end

	# FRIENDLY FORWARDING
	# redirects to stored location (or to the default)
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

	# stores the URL trying to be accessed
	def store_location
		session[:forwarding_url] = request.url if request.get? # only for get requests
	end
end
