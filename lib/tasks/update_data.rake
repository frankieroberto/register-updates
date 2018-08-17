namespace :update do

  task :data => [:environment] do
    ImportRegistersJob.new.perform

    Register.find_each do |register|
      ImportRecordsJob.new.perform(register.id)
    end

    Register.find_each do |register|
      ImportEntriesJob.new.perform(register.id)
    end

    Register.find_each do |register|
      register.update_last_updated_at!
    end
  end

end
