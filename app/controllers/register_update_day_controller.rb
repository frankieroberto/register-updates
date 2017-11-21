class RegisterUpdateDayController < ApplicationController

  def show

    @register = Register.find_by!(code: params[:register_id])

    @day = Date.parse("#{params[:year_id]}-#{params[:month_id]}-#{params[:id]}")

    @update_day = UpdateDay
      .for_register(@register)
      .for_day(@day)
      .limit(30)
      .order("day desc, register_code desc")

    render 'register_updates/day'

  end

end
