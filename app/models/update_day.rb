class UpdateDay
  include Enumerable

  def self.order(order)
    new.order(order)
  end

  def self.limit(limit)
    new.limit(limit)
  end

  def self.for_register(for_register)
    new.for_register(for_register)
  end

  def limit(limit)
    @limit = limit
    self
  end

  def order(order)
    @order = order
    self
  end

  def for_register(register)
    @register_code = register.code
    self
  end

  def for_day(date)
    @date = date
    self
  end

  def each &block
    results.each(&block)
  end

  private

  def results

    query = Entry
      .select("sum(case when previous_entry_id is not null then 1 else 0 end) as updated_count, sum(case when previous_entry_id is null then 1 else 0 end) as new_entries_count, date_trunc('day',timestamp) as day, register_code, registers.name as register_name")
      .joins(:register)
      .group("date_trunc('day',timestamp), register_code, register_name")
      .order(@order)
      .limit(@limit)

    if @date
      query = query.where(["date_trunc('day',timestamp) = ?", @date.strftime("%Y-%m-%d")])
    end

    if @register_code
      query = query.where(register_code: @register_code)
    end

    query.group_by {|e| e["day"]}
  end

end
