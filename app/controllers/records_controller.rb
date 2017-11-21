class RecordsController < ApplicationController

  def show

    @register = Register.find_by!(code: params[:register_id])

    @record = Record.find_by!(register_code: params[:register_id], key: params[:id])

    @entries = @record.entries.order(:number).reverse_order.limit(50)

  end

end
