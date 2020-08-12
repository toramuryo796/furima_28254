class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :image,         null: false
      t.string     :title,         null: false
      t.text       :explain,          null: false
      t.integer    :price,         null: false
      t.integer    :category,      null: false
      t.integer    :status,        null: false
      t.integer    :fee,           null: false
      t.integer    :origin_area,   null: false
      t.integer    :take_days,     null: false
      t.references :user,          null: false, foreign_key: true
      t.timestamps
    end
  end
end
