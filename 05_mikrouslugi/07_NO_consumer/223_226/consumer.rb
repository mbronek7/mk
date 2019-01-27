#!/usr/bin/env ruby
#*******************************************************************************
# Biblioteki
#*******************************************************************************
require 'bunny'
require 'active_record'
require 'logger'
#*******************************************************************************
# Konfiguracja
#*******************************************************************************
DATABASE = 'logs'
USERNAME = 'logs'
PASSWORD = 'abc123!'
HOSTNAME = '172.28.128.11'
#
R_USERNAME = 'guest' 
R_PASSWORD = 'guest'
R_HOSTNAME = '172.28.128.11'
R_PORT     = '5555'
R_RABBITMQ = "amqp://#{R_HOSTNAME}:#{R_PORT}"
#*******************************************************************************
# Mapowanie klas ActiveRecord
#*******************************************************************************
class Message < ActiveRecord::Base
  self.table_name = 'messages'
end # Message
#*******************************************************************************
# Przetwarzanie
#*******************************************************************************
class Consumer 
  attr_accessor :connection, :channel, :queue, :reply_queue, :exchange, :logger
  def initialize(server_queue_name)
    @logger = Logger.new('consumer.log')
    @connection = Bunny.new(R_RABBITMQ, automatically_recover: false)
    @connection.start
    @channel = connection.create_channel
    @exchange = @channel.default_exchange
    @queue = @channel.queue(server_queue_name)
    @conn = ActiveRecord::Base.establish_connection(:adapter=>'postgresql',
      :encoding=>'unicode',
      :pool=>20,
      :database=>DATABASE,
      :username=>USERNAME,
      :password=>PASSWORD,
      :host=>    HOSTNAME)
    setup_listener
  end # initialize
  def stop
    channel.close
    connection.close
  end # stop
  private
  def setup_listener
    logger.info("[*] consumer waiting")
    @queue.subscribe(:block => true) do |_delivery_info, properties, payload|
      msg = "#{Time.now.to_s} -> received @ #{$$} -> #{payload}"
      logger.info(msg)
      puts msg
      message = Message.new
      message.content = payload
      message.save!
    end # @queue.subscribe
  end # setup_listener
end # Consumer
#*******************************************************************************
# Uruchomienie
#*******************************************************************************
consumer = Consumer.new('messages')

