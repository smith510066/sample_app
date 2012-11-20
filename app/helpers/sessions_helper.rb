module SessionsHelper
	def sign_in(user)

	cookies.permanent[:remember_token] = user.remember_token
	self.current_user = user
	end

	 def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
  	self.current_user = nil
  	cookies.delete(:remember_token)
  end

  def current_user?(user)
    user == current_user
  end


  def friendly_redirect(default)
    if session[:return_to] == nil
      redirect_to default
    else
      redirect_to session[:return_to]
      session.delete(:return_to)
    end
  end

  def store_location
    session[:return_to] = request.url
  end


end
