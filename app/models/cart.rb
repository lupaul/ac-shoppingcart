class Cart < ApplicationRecord
  has_many :cartitems, dependent: :destroy

  def find_cart_item(product)
    cartitems.find_by(product_id: product)
  end

  def clean!
    cartitems.destroy_all
  end

  def total_price
    sum =0
    cartitems.each do |cartitem|
      sum = sum + (cartitem.product.price * cartitem.quantity)
    end
    sum
  end

  
  def total_qty
    cartitems.map{ |x| x.qty }.sum

  end

  def add_product(product)
    existing = cartitems.find_by_product_id( product.id)
    if existing
      existing.qty += 1
      existing.save!
    else
      item = cartitems.build(product_id: product.id, qty: 1)
      item.save!
    end
  end
  #
  # def add_product(product)
  #   existing_item = self.cartitems.find_by_product_id( product.id )
  #   if existing_item
  #     existing_item.qty += 1
  #     existing_item.save!
  #   else
  #     item = self.cartitems.build( :product_id => product.id, :qty => 1 )
  #     item.save!
  #   end
  # end
end
