class ProductModelsController < ApplicationController
  def index
    @product_models = ProductModel.all
  end
end