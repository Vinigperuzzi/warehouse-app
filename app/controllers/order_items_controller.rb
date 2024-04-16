class OrderItemsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @products = @order.supplier.product_models
    @order_item = OrderItem.new
  end

  def create
    @order = Order.find(params[:order_id])
    order_item_params = params.require(:order_item).permit(:product_model_id, :quantity)

    @order.order_items.create(order_item_params)

    redirect_to @order, notice: 'Item adicionado com sucesso.'
  end
end