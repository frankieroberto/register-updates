class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.integer :record_id, null: false
      t.text :register_code, null: false
      t.integer :number, null: false
      t.datetime :timestamp, null: false
      t.text :item_hash, null: false
      t.json :values
    end

    add_foreign_key :entries, :records
    add_foreign_key :entries, :registers, column: 'register_code', primary_key: 'code'

  end
end
