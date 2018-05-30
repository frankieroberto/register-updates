require 'open-uri'

class ImportEntriesJob < ApplicationJob
  queue_as :default

  def perform(register_id)

    register = Register.find(register_id)

    entries_added_count = 0

    url = "#{register.url}/entries.json?limit=5000&start=0"


    puts url
    begin

      file = open(url, "Authorization" => ENV.fetch('API_KEY')).read
      json = JSON.parse(file)

      json.each do |entry_values|

        record = Record.find_or_initialize_by(register_code: register.code, key: entry_values['key'])

        record.values ||= {}
        record.save!

        entry = Entry.find_or_initialize_by(register_code: register.code, record_id: record.id, item_hash: entry_values['item-hash'][0])

        entry.number = entry_values['entry-number']
        entry.timestamp = entry_values['entry-timestamp']

        raise "More than one item for entry #{entry.number} in #{register.code}" if entry_values['item-hash'].size != 1

        entries_added_count += 1 if entry.new_record?

        entry.save!

        if !entry.values
          ImportEntryJob.new.perform(entry.id)
        end
      end

    rescue OpenURI::HTTPError, SocketError => e
      puts e

    end

    puts "#{entries_added_count} entries added for #{register.name}" if entries_added_count > 0

  end
end
