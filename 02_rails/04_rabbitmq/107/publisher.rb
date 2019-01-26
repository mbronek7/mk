class Publisher
  def self.publish(queue, message = {})
    q = channel.queue(queue)
    channel.default_exchange.publish(message.to_json, routing_key: q.name)
  end # publish
  def self.channel
    @channel ||= connection.create_channel
  end #channel
  def self.connection
    @connection ||= Bunny.new.tap do |c|
      c.start
    end
  end # connection
end # Publisher

