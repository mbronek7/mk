Dir[File.join(__dir__, '..', 'models', '*.rb')].each { |file| 
  require file 
} # models
Dir[File.join(__dir__, '..', 'grids', '*.rb')].each { |file| 
  require file 
} # grids
class AutomaticsController < ApplicationController
  def index
    table_name = params[:table_name]
    grid_class = "#{table_name}_grid".classify.constantize
    @grid = grid_class.new(params["#{table_name}_grid"])
    @assets = @grid.assets
      #.page(params[:page])
  end # index
  private
  def strong_params
  end # strong_params
end # AutomaticsController

