class Register < ApplicationRecord

  has_many :entries, foreign_key: 'register_code', primary_key: 'code'
  has_many :records, foreign_key: 'register_code', primary_key: 'code'

  def url
    "https://#{code}.#{host || 'register.gov.uk'}"
  end

end
