ActiveRecord::Base.connection.tables.each do |table|
  model_class = table.classify
  eval <<DYNAMIC
    class #{model_class} < ApplicationRecord
    end
DYNAMIC
end # tables
