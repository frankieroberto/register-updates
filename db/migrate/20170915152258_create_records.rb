class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.text :register_code, null: false
      t.text :key, null: false
      t.json :values, null: false
    end

    add_foreign_key :records, :registers, column: 'register_code', primary_key: 'code'
    add_index :records, [:register_code, :key], unique: true
  end
end
