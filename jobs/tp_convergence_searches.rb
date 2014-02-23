# Populate the graph with some random points

url = 'http://tp.aviasales.ru/report.php?r=105&u1=1&m=4&h=e449e6ae9ecada35d18818b6f7358654578391d4&export=json'


data = Oj.load(RestClient.get(url))[0][1]
points = []
#points << { x: 1, y: 500 }
last_x = 1#points.last[:x]

SCHEDULER.every '60s' do
  data = Oj.load(RestClient.get(url))[0][1]
  if points.size > 10
    points.shift
  end
  last_x += 1
  points << { x: last_x, y: data }

  send_event('tp_convergence_searches', points: points)
end
