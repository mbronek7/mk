#*******************************************************************************
# Biblioteki
#*******************************************************************************
require 'rubygems'
require 'json'
require 'active_record'
require 'active_support'
require 'active_support/core_ext'
require 'json'
#*******************************************************************************
# Parametryzacja
#*******************************************************************************
PARAM_DB_NAME  = ARGV[0]
PARAM_DB_USER  = ARGV[1]
PARAM_DB_PASS  = ARGV[2]
#*******************************************************************************
# Połączenie
#*******************************************************************************-
conn = ActiveRecord::Base.establish_connection(:adapter=>"postgresql",
                                               :encoding=>"unicode", 
                                               :pool=>1,
                                               :database=>"#{PARAM_DB_NAME}",
                                               :username=>"#{PARAM_DB_USER}",
                                               :password=>"#{PARAM_DB_PASS}",
                                               :host=>"172.28.128.11")
if conn.nil? then raise '!: NO -AR- CONNECTION' end
#*******************************************************************************
# Dynamiczne mapowanie klas ActiveRecord
#*******************************************************************************
tables = conn.connection.tables
tables.each do |table|
  class_name = table.classify
  begin
  eval <<DYNAMIC
  class #{class_name} < ActiveRecord::Base
    self.table_name = "#{table}"
    self.inheritance_column = :_type_disabled
  end  
DYNAMIC
  rescue
  end # begin/rescue
end # tables

def top_bottom(t)
  val = ""
  if !t[0].to_s.blank? then
    val = t[0].to_s.delete("\n").to_s[0..19].gsub('"', "'")
  end # if
  return { "#{val}": t[1].to_s }
end # top_bottom

#*******************************************************************************
# Statystyka
#*******************************************************************************
ActiveSupport::Deprecation.silenced = true
Time::DATE_FORMATS[:no_timezone] = "%Y-%m-%d %H:%M:%S"
$stdout.sync = true
json = {}
tables.each do |table| 
  if table == "files" then next end
  tbl = {}
  fields = []
  cnt = table.classify.constantize.count
  tbl[:count] = cnt
  limit = 29
  table.classify.constantize.new.attributes.map { |x| 
    attrs = {}
    field = x[0]
    if !field.blank? then
      last_nn_val = table.classify.constantize.select(field).last[field].to_s[0..limit] rescue 'N\A'
      null_count  = table.classify.constantize.where("#{field} IS NULL").count rescue 'N/A'
      min_val     = table.classify.constantize.where("#{field} IS NOT NULL").minimum("#{field}").to_s[0..limit] rescue 'N/A'
      max_val     = table.classify.constantize.where("#{field} IS NOT NULL").maximum("#{field}").to_s[0..limit] rescue 'N/A'
      avg_val     = table.classify.constantize.where("#{field} IS NOT NULL").average("#{field}").to_s[0..limit] rescue 'N/A'
      top10       = table.classify.constantize.group("#{field}").order("COUNT(#{field}) DESC").limit(10).count
      bottom10    = table.classify.constantize.group("#{field}").order("COUNT(#{field}) ASC").limit(10).count
      distinct    = table.classify.constantize.select("DISTINCT #{field}").count
      attrs[:name] = x[0]
      attrs[:uniq] = distinct
      attrs[:last] = last_nn_val
      attrs[:null] = "#{null_count} (#{((null_count.to_f/cnt.to_f)*100) rescue '-'}%)"
      attrs[:min]  = min_val
      attrs[:max]  = max_val
      attrs[:avg]  = avg_val
      tops = []
      bottoms = []
      top10.each do |t|  
        tops << top_bottom(t)
      end # top10
      bottom10.each do |t| 
        bottoms << top_bottom(t)
      end # 
      attrs[:tops] = tops
      attrs[:bottoms] = bottoms
    else
      raise "!: FIELD IS BLANK"
    end # if
    fields << attrs
  } # fields
  tbl[:fields] = fields
  json[table] = tbl
end # tables

puts json.to_json

