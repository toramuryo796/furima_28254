class CreateOriginAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :origin_areas do |t|
      t.timestamps
    end
  end
end
