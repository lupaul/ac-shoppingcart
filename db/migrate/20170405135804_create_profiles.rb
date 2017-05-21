class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|

    	t.string :name
    	t.string :phone
    	t.string :address
    	t.string :email
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
