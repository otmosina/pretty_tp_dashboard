# Populate the graph with some random points
#require 'oj'
#
#
#class ReportWidget
#  @@url = 'http://tp.aviasales.ru/report.php?r=111&u1=%s&u2=%s&m=4&h=a55dea1e249f3abee09648f194c93353aa8f1ffb&export=json'
#  def self.fetch day_ago, type_column
#    url_custom = @@url % [day_ago, type_column]
#    data = Oj.load(RestClient.get(url_custom))
#    return data[0][1], data[0][0].split(" ")[1].to_i
#  end
#end


=begin

points = []
i = 0


Constant.widget_count_columns.downto(0) do |hour_ago|
  value = ReportWidget.fetch( hour_ago, 'clicks' )[0]
  points << { x: i, y: value }
  i += 1
end
last_hour = ReportWidget.fetch( 0, 'clicks' )[1]
last_x = points.last[:x]

SCHEDULER.every '20s' do
  if Time.now.utc.hour != last_hour
    points.shift
    last_x += 1
  else
    points.pop
  end
  value, last_hour = ReportWidget.fetch( 0, 'clicks' )
  points << { x: last_x, y: value }
  send_event('tp_convergence_widget3', points: points)
end

=end







