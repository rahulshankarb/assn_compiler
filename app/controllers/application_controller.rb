class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to root_url
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
      redirect_to error_url
  end

  rescue_from ActionController::RoutingError do |exception|
      redirect_to error_url
  end


 def not_authenticated
  redirect_to login_url, :alert => "First login to access this page."
 end



 private

 def set_locale
 	I18n.locale = params[:locale] if params[:locale].present?
 end

 def default_url_options(options = {})
  	 {:locale => I18n.locale }
 end

end
