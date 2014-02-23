require 'oj'
require 'rest-client'
require 'pry'
# this is just the dummy sample using random data to illustrate
# replace the random data with your real data... wherever you get it from


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

