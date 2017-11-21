class RegistersController < ApplicationController

  def show

    @register = Register.find_by!(code: params[:id])

    @update_days = UpdateDay
      .for_register(@register)
      .limit(30)
      .order("day desc, register_code desc")

    @recent_entries = @register.entries.order('timestamp').reverse_order.limit(500)

  end

  def index
    @registers = Register.all
  end

end
