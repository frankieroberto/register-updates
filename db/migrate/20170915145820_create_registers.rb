class CreateRegisters < ActiveRecord::Migration[5.1]
  def change
    create_table :registers do |t|
      t.text :code, null: false
      t.text :name, null: false
      t.text :registry, null: false
      t.text :phase, null: false
    end

    add_index :registers, :code, unique: true

  end
end
