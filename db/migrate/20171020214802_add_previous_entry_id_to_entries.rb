class AddPreviousEntryIdToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :previous_entry_id, :integer

    add_foreign_key :entries, :entries, column: 'previous_entry_id', primary_key: 'id'

  end
end
