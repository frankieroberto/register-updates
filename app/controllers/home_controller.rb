class HomeController < ApplicationController

  def show

    @update_days = UpdateDay
      .limit(100)
      .order("day desc, register_code desc")

    @entries_by_date = Entry
      .order('timestamp')
      .reverse_order
      .limit(100)
      .group_by {|e| e.timestamp.to_date }

  end

end
