current_valuation = 0
current_karma = 0

url_day_ago = 'http://tp.aviasales.ru/report.php?r=106&u1=1&m=4&h=d809f270d0500bcc748b87f5f00cc3921275e228&export=json'
data = Oj.load(RestClient.get(url_day_ago))[0][1]
url = 'http://tp.aviasales.ru/report.php?r=106&u1=0&m=4&h=d809f270d0500bcc748b87f5f00cc3921275e228&export=json'


get_all_profit_url = "http://tp.aviasales.ru/report.php?r=141&u1=2014-04-01&m=4&h=1c2d65e341efacd518223d0ea349305e753cfd28&export=json"
last_valuation = data

general_goal_profit = Constant.final_goal


SCHEDULER.every '2s' do
  #last_valuation = current_valuation
  #last_karma     = current_karma
  current_valuation = Oj.load(RestClient.get(url))[0][1]
  current_goal_profit = Oj.load(RestClient.get(get_all_profit_url))[0][1]
  #current_karma     = rand(200000)

  send_event('valuation', { current: current_valuation, last: last_valuation })
  send_event('goal_profit', { current: current_goal_profit, last: general_goal_profit })


  send_event('synergy',   { value: 0 })
end
