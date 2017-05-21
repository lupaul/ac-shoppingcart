class CreateCartitems < ActiveRecord::Migration[5.0]
  def change
    create_table :cartitems do |t|
      t.integer :product_id
      t.integer :cart_id ,index: true
      t.integer :qty
      t.timestamps
    end
  end
end
