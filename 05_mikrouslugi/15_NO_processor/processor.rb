#!/usr/bin/env ruby
#############
# LIBRARIES
#############
require 'active_record'
require 'logger'
require 'json'
require 'bigdecimal'
#############
# DATA
#############
DATABASE = 'logs'
USERNAME = 'logs'
PASSWORD = 'abc123!'
HOSTNAME = '172.28.128.11'
#############
# CLASSES 
#############
class Message < ActiveRecord::Base
  self.table_name = 'messages'
end
class Readout < ActiveRecord::Base
  self.table_name = 'readouts'
end
#############
# MAIN 
#############
class CspProcessor
  attr_accessor :logger, :conn
  def initialize()
    @logger = Logger.new('processor.log')
    @conn = ActiveRecord::Base.establish_connection(:adapter=>'postgresql',
      :encoding=>'unicode',
      :pool=>20,
      :database=>DATABASE,
      :username=>USERNAME,
      :password=>PASSWORD,
      :host=>    HOSTNAME)
    task
  end # initialize
  private
  def task
    logger.info("[*] consumer waiting")
    while true 
      begin
        messages = Message.where("processed_at IS NULL")
        messages.each do |message|
          Readout.transaction do
            r = Readout.new
            r.data_type = 'adc0'
            parsed = JSON.parse(message.content)
            r.content = parsed["adc"]
            r.message_id = message.id
            r.save!
            message.processed_at = Time.now
            message.save!
            puts r.inspect
          end 
        end # each
      rescue Exception => e
        logger.error("[e] Exception occured -> #{e.inspect}")
      end
      sleep 1
    end # while 
  end # task
end # CspProcessor
#############
# PROGRAM
#############
processor = CspProcessor.new

