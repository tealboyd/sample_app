class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # by default, all helpers available to views but not controllers
  # need to be explictly included
  include SessionsHelper
end
