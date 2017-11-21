class CreateUpdateDays < ActiveRecord::Migration[5.1]
  def change
    create_table :update_days do |t|
      t.string :register_code, null: false
      t.date :day, null: false
      t.integer :records_added_count, null: false
      t.integer :records_updated_count, null: false
    end
    add_foreign_key :update_days, :registers, column: 'register_code', primary_key: 'code'

  end
end
