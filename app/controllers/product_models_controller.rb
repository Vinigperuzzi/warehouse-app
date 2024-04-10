class ProductModelsController < ApplicationController
  def index
    @product_models = ProductModel.all
  end

  def show
    @product_model = ProductModel.find(params[:id])
  end

  def new
    @product_model = ProductModel.new
    @supplier = Supplier.all
  end

  def create
    @product_model = ProductModel.new(get_params)
    if @product_model.save
      redirect_to @product_model, notice: 'Modelo de Produto cadastrado com sucesso'
    else
      flash.now[:notice] = 'Produto não cadastrado'
      render 'new'
    end
  end

  def get_params
    params.require(:product_model).permit(:name, :weight, :height, :width, :depth, :sku, :supplier_id)
  end
end