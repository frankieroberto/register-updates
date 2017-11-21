class Entry < ApplicationRecord

  belongs_to :register, foreign_key: 'register_code', class_name: 'Register', primary_key: 'code', optional: true
  # belongs_to :previous_entry, foreign_key: 'previous_entry_id', optional: true
  belongs_to :record

  def name
    values.to_h["name"] || values.to_h["hostname"] || values.to_h[register_code] || values.to_s
  end

  def record_added?
    previous_entry_id == nil
  end

  def record_updated?
    !record_added?
  end

  def changed_fields

    if previous_entry && previous_entry.values && values

      changed_fields = []

      (previous_entry.values.keys + values.keys).uniq.each do |key|

        if previous_entry.values[key] != values[key]
          changed_fields << {key: key, previous: previous_entry.values[key]}
        end
      end

      changed_fields


    else
      []
    end

  end

  def previous_entry
    Entry.where(record_id: record_id)
    .where("number < ?", number)
      .order(:timestamp).reverse_order
      .limit(1).first
  end

end
