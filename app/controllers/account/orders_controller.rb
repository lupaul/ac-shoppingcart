class Account::OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order("id DESC")
  end

  def order_cancel
    @order = Order.find_by(token: params[:id])
    @order.update(aasm_state: "user_order_cancelled")

    redirect_to :back
  end
end
