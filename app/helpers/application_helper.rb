module ApplicationHelper

  def linked_field(field)

    if field

      curie_format = /([a-z\-]+)\:(.+)/

      match_result = curie_format.match(field)

      if match_result


        record = Record.find_by(register_code: match_result[1], key: match_result[2])

        if record

          entry = record.entries.order(:timestamp).last

          link_to(entry.name, register_record_path(record.register_code, record.key))
        else
          "NO MATCH: #{field}"
        end

      else
        field
      end
    else
      "(none)"
    end

  end

end
