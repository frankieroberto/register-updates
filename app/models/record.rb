class Record < ApplicationRecord

  has_many :entries
  belongs_to :register, foreign_key: 'register_code', class_name: 'Register', primary_key: 'code'

  def param

  end

  def name
    values.to_h["name"] || values.to_h["hostname"] || values.to_h[register_code] || "???"
  end

  def records_referencing_this_one

    curie_records = Record.where(register_code: 'field').where("values::jsonb @> '{\"datatype\": \"curie\"}'").pluck(:key)

    referencing_records = []

    referencing_records << Record
      .where.not(register_code: register_code)
      .where("records.values::jsonb @> '{\"" + register_code + "\" : \"" + key + "\"}'::jsonb")

    curie_records.each do |curie_field|

      referencing_records << Record
        .where.not(register_code: register_code)
        .where("records.values::jsonb @> '{\"" + curie_field + "\" : [\"#{register_code}:#{key}\"]}'::jsonb")

    end

    referencing_records.flatten.compact
  end

end
