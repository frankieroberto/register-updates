class AddLastUpdatedDateToRegisters < ActiveRecord::Migration[5.1]
  def change
    add_column :registers, :last_updated_at, :datetime
  end
end
