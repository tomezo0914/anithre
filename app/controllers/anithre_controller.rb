class AnithreController < ApplicationController
  before_action :current_omniuser
  helper_method :current_omniuser

  private

  def current_omniuser
    @current_omniuser ||= Omniuser.where("id = ?", session[:user_info]).first if session[:user_info]
  end
end
