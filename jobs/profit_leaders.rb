require 'oj'
require 'rest-client'
require 'pry'
url = 'http://tp.aviasales.ru/report.php?r=110&u1=0&m=4&h=4e3d921743607223d1c373c3d39b6d8bd4f6073b&export=json'

data = Oj.load(RestClient.get(url))
names = data.map do |i|
  result = i[3].nil? ? i[4] : i[3]
  if result.to_s.size == 0
    result = i[2]
  end
  result
end
profits = data.map{|i| i[1] }
result_array = []
names.each_with_index do |name, index|
  result_array << { label: name, value: profits[index]}
end

#buzzwords = ['Paradigm shift', 'Leverage', 'Pivoting', 'Turn-key', 'Streamlininess', 'Exit strategy', 'Synergy', 'Enterprise', 'Web 2.0']
#buzzword_counts = Hash.new({ value: 0 })

SCHEDULER.every '60s' do
  #random_buzzword = buzzwords.sample
  #buzzword_counts[random_buzzword] = { label: random_buzzword, value: (buzzword_counts[random_buzzword][:value] + 1) % 30 }

  send_event('profit_leaders', { items: result_array })
end

