class ProductModelsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
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
      @supplier = Supplier.all
      flash.now[:notice] = 'Não foi possível cadastrar o modelo de produto.'
      render 'new'
    end
  end

  def get_params
    params.require(:product_model).permit(:name, :weight, :height, :width, :depth, :sku, :supplier_id)
  end
end