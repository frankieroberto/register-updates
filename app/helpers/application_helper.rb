module ApplicationHelper

  def linked_named_field(field, key)

    field_record = Record.find_by(register_code: 'field', key: field)
    associated_register = Register.find_by(code: key)

    if (field_record && field_record.values['register'].present?) || associated_register
      associated_record = Record.find_by(register_code: field, key: key)

      if associated_record
        link_to associated_record.name, register_record_path(associated_record.register_code, associated_record.key)
      else
        key || "(none)"
      end
    else
      key || "(none)"
    end

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
