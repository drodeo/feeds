class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :detect_browser
  before_action :set_current_user
  before_action :set_global_search_variable


  def detect_browser
    request.variant = case request.user_agent
                        when /iPad/i
                          :tablet
                        when /iPhone/i
                          :phone
                        when /Android/i && /mobile/i
                          :phone
                        when /Android/i
                          :tablet
                        when /Windows Phone/i
                          :phone
                        else
                          :desktop
                      end
  end

  def set_global_search_variable
    @search = Page.search(params[:q])
  end


  def set_current_user
    User.current = current_user
  end

end


