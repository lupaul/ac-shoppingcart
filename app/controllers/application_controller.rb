class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before :find_cart
  helper_method :current_cart



  def check_admin!
    if current_user && current_user.is_admin?
      # ok
    else
      raise ActionController::RoutingError.new('Not Found')
      # flash[:alert] = "你沒權限"
      # redirect_to root_path
    end
  end

private
def current_cart
  return @cart if @cart

  if session[:cart_id]
    @cart = Cart.find_by_id(session[:cart_id])
    return @cart if @cart
  end

  @cart = Cart.create
  session[:cart_id] = @cart.id

  return @cart
end
  #
  # def find_cart
  #   if session[:cart_id]
  #     @cart = Cart.find(session[:cart_id])
  #   else
  #       @cart = Cart.create
  #       session[:cart_id] = @cart.id
  #   end
  # end
end
