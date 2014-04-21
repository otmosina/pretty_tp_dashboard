require 'rest-client'
require 'oj'
class Report
  WIDGET_STAT_URL = 'http://tp.aviasales.ru/report.php?r=111&u1=%s&u2=%s&m=4&h=a55dea1e249f3abee09648f194c93353aa8f1ffb&export=json'
  AFF_SEARCHES_URL = 'http://tp.aviasales.ru/report.php?r=144&u1=%s&m=4&h=d19f07518ac01c7a5027ae6bbb6c317999d61350&export=json'
  WL_SEARCHES_URL = 'http://tp.aviasales.ru/report.php?r=145&u1=%s&m=4&h=5b5f5cbe3b2c990a96d94ae7c1d20afb69d9ec4e&export=json'
  AFF_PAIDBOOKINGS_URL = 'http://tp.aviasales.ru/report.php?r=146&u1=%s&m=4&h=13c4a9f1cb862324ceee802a3777250d18d2d72f&export=json'


  def self.fetch_widgetstat day_ago, type_column
    puts "request for multi #{type_column} #{day_ago}"

    url_custom = WIDGET_STAT_URL % [day_ago, type_column]
    puts url_custom if type_column == 'inits'
    data = Oj.load(RestClient.get(url_custom))
    return data[0][1], data[0][0].split(" ")[1].to_i
  end

  def self.aff_searches day_ago
    url_custom = AFF_SEARCHES_URL % [day_ago]
    puts "Send aff searches request #{day_ago}"
    data = Oj.load(RestClient.get(url_custom))
    return data[0][1], data[0][0].split(" ")[1].to_i
  end

  def self.aff_paidbookings day_ago
    url_custom = AFF_PAIDBOOKINGS_URL % [day_ago]
    puts "Send aff AFF_PAIDBOOKINGS_URL request #{day_ago}"
    puts "#{url_custom}"
    data = Oj.load(RestClient.get(url_custom))
    return data[0][1], data[0][0].split(" ")[1].to_i
  end

  def self.wl_searches day_ago
    url_custom = WL_SEARCHES_URL % [day_ago]
    puts "Send aff searches request #{day_ago}"
    data = Oj.load(RestClient.get(url_custom))
    return data[0][1], data[0][0].split(" ")[1].to_i
  end

end
