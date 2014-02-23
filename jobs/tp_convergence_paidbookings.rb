# Populate the graph with some random points

url = 'http://tp.aviasales.ru/report.php?r=107&u1=60&m=4&h=14e11623aae5ea2b5cfe07e861aaed9987d0782d&export=json'


#data = Oj.load(RestClient.get(url))[0][1]
#points = []
#points << { x: 1, y: data }
#last_x = points.last[:x]
#
#SCHEDULER.every '60s' do
#  data = Oj.load(RestClient.get(url))[0][1]
#  if points.size > 10
#    points.shift
#  end
#  last_x += 1
#  points << { x: last_x, y: data }
#
#  send_event('tp_convergence_paidbookings', points: points)
#end
