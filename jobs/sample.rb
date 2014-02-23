current_valuation = 0
current_karma = 0


url_day_ago = 'http://tp.aviasales.ru/report.php?r=106&u1=1&m=4&h=d809f270d0500bcc748b87f5f00cc3921275e228&export=json'
data = Oj.load(RestClient.get(url_day_ago))[0][1]
url = 'http://tp.aviasales.ru/report.php?r=106&u1=0&m=4&h=d809f270d0500bcc748b87f5f00cc3921275e228&export=json'

last_valuation = data
SCHEDULER.every '2s' do
  #last_valuation = current_valuation
  last_karma     = current_karma
  current_valuation = Oj.load(RestClient.get(url))[0][1]
  current_karma     = rand(200000)

  send_event('valuation', { current: current_valuation, last: last_valuation })
  send_event('karma', { current: current_karma, last: last_karma })
  send_event('synergy',   { value: 0 })
end
