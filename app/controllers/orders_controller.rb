class OrdersController < ApplicationController

    def index
        @orders = current_user.orders 
    end 
    
    def new
        @order = Order.new 
        @warehouses = Warehouse.all
        @suppliers = Supplier.all
    end

    def create
        order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
        @order = Order.new(order_params)
        @order.user = current_user
        @order.save!
        redirect_to @order, notice: 'Pedido registrado com sucesso'
    end
    
    def show
        @order = Order.find(params[:id])
    end 

    def search
        @code = params["query"]
        @orders = Order.where("code LIKE ?", "%#{@code}%")
    end 
end 
