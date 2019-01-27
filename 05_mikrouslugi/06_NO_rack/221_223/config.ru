%w(action_controller/railtie bunny).map &method(:require)
run TheSmallestRailsApp ||= Class.new(Rails::Application) {
  config.secret_token = routes.append { 
    root 'messages#new'
    post 'messages' => 'messages#new'
  }.inspect
  initialize!
} # run
class Publisher
  def self.publish(queue, message = {})
    q = channel.queue(queue)
    channel.default_exchange.publish(message, routing_key: q.name)
  end # publish
  def self.channel
    @channel ||= connection.create_channel
  end # channel
  def self.connection
    @connection ||= Bunny.new('amqp://guest:guest@172.28.128.11:5555').tap do |c|
      c.start
    end # Bunny.new
  end # connection
end # Publisher
class MessagesController < ActionController::Base
  def new
    payload = request.raw_post
    if payload.blank? then
      render inline: '{ "error":"100", "errorDescription":"Missing payload" }'
      return
    end # if
    Publisher.publish("messages", payload)
    render inline: '{ "requestAccepted":true }'
  end # new
end # MessagesController

