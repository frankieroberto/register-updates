module ApplicationHelper


  def field_link(field)
    link_to field,register_record_path('field', field)
  end


  def linked_named_field(field, keys)

    Array(keys).collect do |key|

      curie_format = /([a-z\-]+)\:([^\/].+)/

      if match_result = curie_format.match(key)

        associated_record = Record.find_by(register_code: match_result[1], key: match_result[2])

      else

        field_record = Record.find_by(register_code: 'field', key: field)

        associated_register_code = field_record.values['register']

        if associated_register_code

          associated_record = Record.find_by(register_code: associated_register_code, key: key)
        else
          associated_record = nil
        end

      end

      if associated_record

        link_to associated_record.name, register_record_path(associated_record.register_code, associated_record.key)

      elsif field_record && field_record.values['datatype'] == 'datetime'

        begin
          Date.parse(key.to_s).to_s(:long)
        rescue ArgumentError
          key
        end

      elsif field_record && field_record.values['datatype'] == 'url'

        link_to key, key

      else
        key
      end
    end.join('<br>').html_safe

  end


  def linked_field(field)

    if field

      curie_format = /([a-z\-]+)\:([^\/].+)/

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
