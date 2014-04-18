module Constant
  @final_goal = 22_000_000
  def final_goal
    return @final_goal
  end

  def final_goal=(val_final_goal)
    @final_goal = val_final_goal
  end

  def widget_count_columns
    return 23
  end

  extend self
end
