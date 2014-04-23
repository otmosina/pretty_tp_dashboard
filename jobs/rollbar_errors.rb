require 'oj'
require 'rest-client'
require 'pry'


rollbar_errors = RollbarFetcher.new 'eed4f2b3576b4a4dac5890abc675d016'
rollbar_errors.fetch_all
array_errors = rollbar_errors.all_errors

top_last_errors = array_errors.sort_by{|a|a["last_occurrence_timestamp"]}.reverse[0..5]
pretty_last_errors=top_last_errors.map do |elem|
  {
    title: elem["title"],
    err_count: elem["total_occurrences"],
    last_date: Time.at(elem["last_occurrence_timestamp"])
  }
end

result_array = []
pretty_last_errors.each do |elem|
  result_array << { label: elem[:title], value: elem[:err_count]}
end

#buzzwords = ['Paradigm shift', 'Leverage', 'Pivoting', 'Turn-key', 'Streamlininess', 'Exit strategy', 'Synergy', 'Enterprise', 'Web 2.0']
#buzzword_counts = Hash.new({ value: 0 })

SCHEDULER.every '60s' do
  #random_buzzword = buzzwords.sample
  #buzzword_counts[random_buzzword] = { label: random_buzzword, value: (buzzword_counts[random_buzzword][:value] + 1) % 30 }

  send_event('rollbar_errors', { items: result_array })
end

