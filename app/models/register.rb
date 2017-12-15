class Register < ApplicationRecord

  has_many :entries, foreign_key: 'register_code', primary_key: 'code', dependent: :destroy
  has_many :records, foreign_key: 'register_code', primary_key: 'code', dependent: :destroy

  def url
    "https://#{code}.#{host || 'register.gov.uk'}"
  end

end
