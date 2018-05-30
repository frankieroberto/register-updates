require 'open-uri'

class ImportRegistersJob < ApplicationJob
  queue_as :default

  def perform(*args)

    registers_changed_count = 0

  	file = open('https://register.register.gov.uk/records.json?page-size=5000', "Authorization" => ENV.fetch('API_KEY')).read

  	json = JSON.parse(file)


  	json.each_pair do |register_code, register_value|


  		register = Register.find_or_initialize_by(code: register_code)

  		register.name = register_value['item'][0]['text']
  		register.registry = register_value['item'][0]['registry']
  		register.phase = register_value['item'][0]['phase']

      registers_changed_count += 1 if register.changed?
      puts "New register: #{register.name}" if register.new_record?

  		register.save

  	end

  	puts "Updated #{registers_changed_count} registers"

  end
end
