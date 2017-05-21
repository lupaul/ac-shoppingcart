class Order < ApplicationRecord
  include AASM
  belongs_to :user, optional: true
  has_many :items, class_name: "OrderItem", dependent: :destroy
  has_one :info, class_name: "OrderInfo", dependent: :destroy
  accepts_nested_attributes_for :info
  before_create :generate_token

  def generate_token
    self.token = SecureRandom.uuid
  end

  def set_payment_with!(method)
    update_columns(payment_method: method)
  end

  def pay!
    update_columns(is_paid: true)
  end

  def build_item_cache_from_cart(cart)
    cart.cartitems.each do |cart_item|
      item = items.build
      item.product_name = cart_item.product.name
      # item.quantity = cart.cart_item.find_by(product_id: cart_item).quantity
      # item.quantity = cart.find_cart_item(cart_item).quantity
      item.quantity = cart_item.quantity
      item.price = cart_item.product.price
      item.save
    end
  end

  def calculate_total!(cart)
    self.total = cart.total_price
    self.save

  end

  aasm do
    state :order_placed, initial: true
    state :paid
    state :shipping
    state :shipped
    state :order_cancelled
    state :good_returned
    state :user_order_cancelled

    # event :make_payment do
    event :make_payment, after_commit: :pay! do
      transitions from: :order_placed, to: :paid
    end

    event :ship do
      transitions from: :paid, to: :shipping
    end

    event :deliver do
      transitions from: :shipping, to: :shipped
    end

    event :return_good do
      transitions from: :shipped, to: :good_returned
    end

    event :cancell_order do
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end
  end

end
