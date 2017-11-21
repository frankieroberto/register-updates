class AddHostToRegisters < ActiveRecord::Migration[5.1]
  def change
    add_column :registers, :host, :text
  end
end
