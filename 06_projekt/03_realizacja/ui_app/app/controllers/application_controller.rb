class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  around_action :handle_execute_action
  def handle_execute_action
    @e = Execution.new
    @e.action = params[:controller] + "#" + params[:action]
    @e.params = params.inspect
    @e.query = request.query_parameters
    @e.referer = request.referer
    @e.user_agent = request.headers['HTTP_USER_AGENT'].to_s
    if current_user
      @e.user_id = current_user.id
    end
    @e.save!
      yield
    @e.touch
  end # handle_execute_action
end # ApplicationController

