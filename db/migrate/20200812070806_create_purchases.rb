class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.string     :postal_code,     null: false
      t.integer    :origin_area_id,  null: false
      t.string     :city,            null: false
      t.string     :house_number,    null: false
      t.string     :building_name,   null: false
      t.string     :phone_number,    null: false
      t.references :user,            null: false, foreign_key: true
      t.references :item,            null: false, foreign_key: true
      t.timestamps
    end
  end
end
