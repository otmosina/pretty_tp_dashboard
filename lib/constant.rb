module Constant
  @final_goal = 22_000_000
  def final_goal
    return @final_goal
  end

  def current_date_profit_goal
    quarter_days_count = Date.parse("1/7/2014").mjd - Date.parse("1/4/2014").mjd
    goal_per_one_day = @final_goal / quarter_days_count
    finished_quarter_days = Date.today.mjd - Date.parse("1/4/2014").mjd

    return finished_quarter_days * goal_per_one_day
  end

  def final_goal=(val_final_goal)
    @final_goal = val_final_goal
  end

  def graph_count_columns
    return 12
  end

  def time_shifts
    [ 0, 24, 24*7 ]
  end

  extend self
end
