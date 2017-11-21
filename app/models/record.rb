class Record < ApplicationRecord

  has_many :entries
  belongs_to :register, foreign_key: 'register_code', class_name: 'Register', primary_key: 'code'

  def param

  end

  def name
    values.to_h["name"] || values.to_h["hostname"] || values.to_h[register_code] || "???"
  end

end
