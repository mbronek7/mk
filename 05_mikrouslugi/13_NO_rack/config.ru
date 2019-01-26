%w(action_controller/railtie coderay bunny).map &method(:require)
run TheSmallestRailsApp ||= Class.new(Rails::Application) {
  config.secret_token = routes.append { 
    root 'messages#new'
    post 'messages' => 'messages#new'
  }.inspect
  initialize!
}
class Publisher
  def self.publish(queue, message = {})
    q = channel.queue(queue)
    channel.default_exchange.publish(message, routing_key: q.name)
  end
  def self.channel
    @channel ||= connection.create_channel
  end
  def self.connection
    @connection ||= Bunny.new('amqp://guest:guest@172.28.128.11:5555').tap do |c|
      c.start
    end
  end
end
class MessagesController < ActionController::Base
  def new
    payload = request.raw_post
    if payload.blank? then
      render inline: '{ "error":"100", "errorDescription":"Missing payload" }'
      return
    end
    Publisher.publish("messages", payload)
    render inline: '{ "requestAccepted":true }'
  end
end
