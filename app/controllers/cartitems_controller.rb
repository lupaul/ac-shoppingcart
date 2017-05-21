class CartitemsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @cart = current_cart
    @item = @cart.cartitems.find_by( params[:id])
    # @item = @cart.find_cart_item(params[:id])
    @product = @item.product
    @item.destroy
    flash[:warning] = "Success delete #{@product.name} from shopping cart"
    redirect_to :back
  end

  def update
    @cart = current_cart
    @item = @cart.cartitems.find_by(id: params[:id])
    @item.update(item_params)
    redirect_to :back
  end

  private

  def item_params
    params.require(:cartitem).permit(:quantity)
  end
end
