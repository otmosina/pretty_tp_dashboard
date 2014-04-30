require 'rest-client'
require 'oj'
class Report
  WIDGET_STAT_URL = 'http://tp.aviasales.ru/report.php?r=111&u1=%s&u2=%s&m=4&h=a55dea1e249f3abee09648f194c93353aa8f1ffb&export=json'

  REPORT_URLS = {
    wl_searches: "http://tp.aviasales.ru/report.php?r=145&u1=%s&m=4&h=5b5f5cbe3b2c990a96d94ae7c1d20afb69d9ec4e&export=json",
    aff_paidbookings: "http://tp.aviasales.ru/report.php?r=146&u1=%s&m=4&h=13c4a9f1cb862324ceee802a3777250d18d2d72f&export=json",
    aff_searches: "http://tp.aviasales.ru/report.php?r=144&u1=%s&m=4&h=d19f07518ac01c7a5027ae6bbb6c317999d61350&export=json"
  }

  def self.fetch_widgetstat day_ago, type_column
    puts "request for multi #{type_column} #{day_ago}"

    url_custom = WIDGET_STAT_URL % [day_ago, type_column]
    puts url_custom if type_column == 'inits'
    data = Oj.load(RestClient.get(url_custom))
    return data[0][1], data[0][0].split(" ")[1].to_i
  end

  def self.fetch_aff_report report_type, day_ago
    url_custom = REPORT_URLS[report_type] % [day_ago]
    puts "Send #{report_type} request #{day_ago}"
    data = Oj.load(RestClient.get(url_custom))
    return data[0][1], data[0][0].split(" ")[1].to_i
  end

end
