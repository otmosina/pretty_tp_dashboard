require 'oj'
require 'rest-client'
require 'pry'
# this is just the dummy sample using random data to illustrate
# replace the random data with your real data... wherever you get it from



points1 = []
points2 = []
points3 = []
i = 0
Constant.widget_count_columns.downto(0) do |hour_ago|
  points1 << { x: i, y: ReportWidget.fetch( hour_ago, 'searches' )[0] }
  points2 << { x: i, y: ReportWidget.fetch( hour_ago+24, 'searches' )[0] }
  points3 << { x: i, y: ReportWidget.fetch( hour_ago+24*7, 'searches' )[0] }
  i += 1
  puts "request for multi #{i}"
end
last_hour = ReportWidget.fetch( 0, 'searches' )[1]
last_x = points1.last[:x]

SCHEDULER.every '10s' do
  if Time.now.utc.hour != last_hour
    points1.shift
    points2.shift
    points3.shift
    last_x += 1
  else
    points1.pop
    points2.pop
    points3.pop
  end
  last_hour = ReportWidget.fetch( 0, 'searches' )[1]
  points1 << { x: i, y: ReportWidget.fetch( 0, 'searches' )[0] }
  points2 << { x: i, y: ReportWidget.fetch( 0+24, 'searches' )[0] }
  points3 << { x: i, y: ReportWidget.fetch( 0+24*7, 'searches' )[0] }
  send_event('multitest', points: [points3, points2, points1])
end

#url = 'http://tp.aviasales.ru/report.php?r=96&u1=3&m=1&h=74adefa7ee34bc1ca73a9c2fdfa6d09f33dcc1cd&export=json' #search per 15 minutes
#
#puts "request...."
#data = Oj.load(RestClient.get(url))
#puts "End request"
#points1 = []
#points2 = []
#points3 = []
#(0..[data[0].size, data[1].size, data[2].size].min-1).each do |i|
#  points1 << { x: i, y: data[0][i][1] }
#  points2 << { x: i, y: data[1][i][1] }
#  points3 << { x: i, y: data[2][i][1] }
#end
#
#last_x = points1.last[:x]
#SCHEDULER.every '30s' do
#  data = Oj.load(RestClient.get(url))
#  points1 = []
#  points2 = []
#  points3 = []
#(0..[data[0].size, data[1].size, data[2].size].min-1).each do |i|
#  points1 << { x: i, y: data[0][i][1] }
#  points2 << { x: i, y: data[1][i][1] }
#  points3 << { x: i, y: data[2][i][1] }
#end
#  send_event('multitest', points: [points3, points2, points1])
#end

