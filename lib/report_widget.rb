require 'rest-client'
require 'oj'
class ReportWidget
  @@url = 'http://tp.aviasales.ru/report.php?r=111&u1=%s&u2=%s&m=4&h=a55dea1e249f3abee09648f194c93353aa8f1ffb&export=json'
  def self.fetch day_ago, type_column
    #puts "Fetch widget #{type_column} column"
    url_custom = @@url % [day_ago, type_column]
    data = Oj.load(RestClient.get(url_custom))
    return data[0][1], data[0][0].split(" ")[1].to_i
  end
end
