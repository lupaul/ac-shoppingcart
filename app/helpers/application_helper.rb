module ApplicationHelper
  def render_cart_items_count(cart)
    cart.cartitems.count
  end
end
