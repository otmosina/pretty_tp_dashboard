

GOAL_PROFIT_URL = "http://tp.aviasales.ru/report.php?r=141&u1=2014-04-01&m=4&h=1c2d65e341efacd518223d0ea349305e753cfd28&export=json"

SCHEDULER.every '60s' do
  general_goal_profit = Constant.current_date_profit_goal
  current_goal_profit = Oj.load(RestClient.get(GOAL_PROFIT_URL))[0][1]
  send_event('goal_profit', { current: current_goal_profit, last: general_goal_profit })
end
