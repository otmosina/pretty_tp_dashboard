
CLEAR_PROFIT_URL = "http://tp.aviasales.ru/report.php?r=106&u1=%s&m=4&h=d809f270d0500bcc748b87f5f00cc3921275e228&export=json"

clear_profit_url_day_ago = CLEAR_PROFIT_URL % 1
clear_profit_url_now = CLEAR_PROFIT_URL % 0

last_day_clear_profit = Oj.load(RestClient.get(clear_profit_url_day_ago))[0][1]

SCHEDULER.every '60s' do
  current_clear_profit = Oj.load(RestClient.get(clear_profit_url_now))[0][1]
  send_event('clear_profit', { current: current_clear_profit, last: last_day_clear_profit })
end
