REPORT_URL = "http://tp.aviasales.ru/report.php?r=143&m=8&h=6598b66357d49fefd816e7d3e022771a99baea68&i=1&export=json"
SERIES = %w[
  searches_today searches_week_ago searches_month_ago
  clicks_today clicks_week_ago clicks_month_ago
  bookings_today bookings_week_ago bookings_month_ago
]

#SCHEDULER.every('15s', first_in: 0) do
#  json = RestClient.get(REPORT_URL)
#  data = Oj.load(json)
#  result = {}
#
#  data.each_with_index do |metric, i|
#    metric_name = SERIES[i]
#    metric = Hash[metric]
#    points = 0.upto(23).map{|j| {x: j, y: (metric[j] || 0)} }
#    result[metric_name] = points
#  end
#
#  send_event("searches", {
#    today: result['searches_today'],
#    week_ago: result['searches_week_ago'],
#    month_ago: result['searches_month_ago']
#  })
#  send_event("clicks", {
#    today: result['clicks_today'],
#    week_ago: result['clicks_week_ago'],
#    month_ago: result['clicks_month_ago']
#  })
#  send_event("bookings", {
#    today: result['bookings_today'],
#    week_ago: result['bookings_week_ago'],
#    month_ago: result['bookings_month_ago']
#  })
#end
