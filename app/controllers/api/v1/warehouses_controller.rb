class Api::V1::WarehousesController < ActionController::API
  #rescue_from ActiveRecordError, with: :return_500
  def show
    begin
      warehouse = Warehouse.find(params[:id])
      render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
    rescue
      render status: 404
    end
  end

  def index
    begin
      warehouses = Warehouse.all.order(:name)
      render status: 200, json: warehouses.as_json(except: [:created_at, :updated_at])
    rescue ActiveRecord::QueryCanceled => e
      render status: 500
    rescue
      render status: 404
    end
  end

  def create
    begin
      warehouse = Warehouse.new(warehouse_params)
      warehouse.save!
      render status: 201, json: warehouse
    rescue ActiveRecord::RecordInvalid => e
      render status: 412, json: { errors: warehouse.errors.full_messages }
    rescue ActiveRecord::ConnectionFailed => e
      render status: 503
    end
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area)
  end
end