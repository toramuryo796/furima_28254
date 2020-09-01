class CreatePersonals < ActiveRecord::Migration[6.0]
  def change
    create_table :personals do |t|
     
      t.string :first_name,          null: false
      t.string :family_name,         null: false
      t.string :first_name_reading,  null: false
      t.string :family_name_reading, null: false
      t.date   :birth_date,          null: false
      t.references :user
      t.timestamps
    end
  end
end
