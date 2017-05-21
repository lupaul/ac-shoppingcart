class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.string :image_url
      t.integer :qty
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
