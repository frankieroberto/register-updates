require 'open-uri'
class ImportEntryJob < ApplicationJob
  queue_as :default

  def perform(entry_id)

    entry = Entry.find(entry_id)

    url = "#{entry.register.url}/item/#{entry.item_hash}.json"

    entry.previous_entry_id = entry.previous_entry.try(:id)

    puts url
    begin
      file = open(url).read

      json = JSON.parse(file)

      entry.values = json



    rescue OpenURI::HTTPError, SocketError => e
      puts e

      raise e

    end

    entry.save!


  end
end
