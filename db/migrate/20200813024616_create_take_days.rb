class CreateTakeDays < ActiveRecord::Migration[6.0]
  def change
    create_table :take_days do |t|

      t.timestamps
    end
  end
end
