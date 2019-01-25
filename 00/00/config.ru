# Strona 11

%w(action_controller/railtie).map &method(:require)
run TheSmallestRailsApp ||= Class.new(Rails::Application) {
  config.secret_token = routes.append { root to: 'hello#world' }.inspect
  initialize!
}
class HelloController < ActionController::Base
  def world
    render inline: "Hello, world!"
  end
end

