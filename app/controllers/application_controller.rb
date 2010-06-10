# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
 before_filter :check_if_session_exists

  private

  def check_if_session_exists
     unless params[:controller] == "user_sessions"
       redirect_to new_user_session_path unless session[:user]
     end
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
