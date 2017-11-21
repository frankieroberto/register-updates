require 'open-uri'

class ImportRecordsJob < ApplicationJob
  queue_as :default

  def perform(register_id)

    register = Register.find(register_id)

    records_changed_count = 0

    url = "#{register.url}/records.json?page-size=5000"

    puts url
    begin

      file = open(url).read

      json = JSON.parse(file)


      json.values.each do |record_values|

        record = Record.find_or_initialize_by(register_code: register.code, key: record_values['key'])

        record.values = record_values['item'][0]

        records_changed_count += 1 if record.changed?

        record.save
      end

    rescue OpenURI::HTTPError => e
      puts url
      puts e

    end

    puts "Updated #{records_changed_count} records for #{register.name}"

  end
end
