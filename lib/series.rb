
class Series
  def initialize

    @series = [
      { name: "Today", data: [] },
      { name: "Day ago", data: [] },
      { name: "Week ago", data: [] }
    ]
  end

  def add_point series_number, x, y
    @series[series_number][:data] << { x: x, y: y }
  end

  def all_shift
    @series[0][:data].shift
    @series[1][:data].shift
    @series[2][:data].shift
    update_x_coord!
  end

  def all_pop
    @series[0][:data].pop
    @series[1][:data].pop
    @series[2][:data].pop
    update_x_coord!
  end

  def update_x_coord!
    @series.each do |ser|
      ser[:data].each_with_index{|point, index| point[:x] = index}
    end
  end

  def last_x
    @series[0][:data].last[:x]
  end

  def get
    return @series
  end
end
