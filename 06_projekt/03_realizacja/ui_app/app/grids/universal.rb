ActiveRecord::Base.connection.tables.each do |table|
  # if table == "schema_migrations" then next end
  # if table == "ar_internal_metadata" then next end
  grid_class = "#{table}_grid".classify
  model_class = table.classify
  eval <<DYNAMIC
    class #{grid_class}
      include Datagrid
      scope do
        #{model_class}.order(:id => :desc).limit(100)
      end
      filter(:id, :integer)
      #{
        str = ""
        table.classify.constantize.new.attributes.map { |x| 
          str = str + "column(:#{x[0]})
"
        }
        str
      }
    end
DYNAMIC
end # tables
