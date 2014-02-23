

COUNT_COL = 12
points = []
i = 0

COUNT_COL.downto(0) do |hour_ago|
  value = ReportWidget.fetch( hour_ago, 'inits' )[0]
  points << { x: i, y: value }
  i += 1
end
last_hour = ReportWidget.fetch( 0, 'inits' )[1]
last_x = points.last[:x]

SCHEDULER.every '10s' do
  if Time.now.utc.hour != last_hour
    points.shift
    last_x += 1
  else
    points.pop
  end
  value, last_hour = ReportWidget.fetch( 0, 'inits' )
  points << { x: last_x, y: value }
  send_event('tp_convergence_widget1', points: points)
end








