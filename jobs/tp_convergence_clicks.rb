# Populate the graph with some random points

url = 'http://tp.aviasales.ru/report.php?r=108&u1=10&m=4&h=a576baeca1b3d79fb8a560e5274cdf0fcca498b1&export=json'


data = Oj.load(RestClient.get(url))[0][1]
points = []
points << { x: 1, y: data }
last_x = points.last[:x]

SCHEDULER.every '60s' do
  data = Oj.load(RestClient.get(url))[0][1]
  if points.size > 10
    points.shift
  end
  last_x += 1
  points << { x: last_x, y: data }

  send_event('tp_convergence_clicks', points: points)
end
