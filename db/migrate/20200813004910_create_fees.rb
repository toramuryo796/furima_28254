class CreateFees < ActiveRecord::Migration[6.0]
  def change
    create_table :fees do |t|
      t.timestamps
    end
  end
end
