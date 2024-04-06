class HomeController < ApplicationController

  def index
    @warehouses = Warehouse.all
  end

end