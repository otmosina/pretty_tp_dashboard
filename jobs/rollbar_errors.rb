require 'oj'
require 'rest-client'
require 'pry'
TOKENS = {
  travelpayouts: { name: "TP", token: "eed4f2b3576b4a4dac5890abc675d016" },
  klit:          { name: "Klit",token: "ec5c67a3c4664bc6ad1bb9f6d800488c" },
  pulse:         { name: "Pulse",token: "53c101b0c2b9410fa56e00e9d3af6161" }
}


project_token = TOKENS[:pulse]
rollbar_fetcher = RollbarFetcher.new

def fetch_and_prepare_errors tokens_hash, rollbar_fetcher
  errors_from_all_projects = []
  tokens_hash.each do |key, project_token|
    array_errors = rollbar_fetcher.fetch_all project_token[:token]
    array_errors.each{|elem| elem["title"] = project_token[:name]+" | "+elem["title"]}
    top_last_errors = array_errors.sort_by{|a|a["last_occurrence_timestamp"]}.reverse[0..5]
    top_last_errors.delete_if{ |elem| Time.at(elem["last_occurrence_timestamp"]).day != Time.now.day  }

    errors_from_all_projects += top_last_errors
  end
  errors_from_all_projects.sort_by!{|a|a["last_occurrence_timestamp"]}.reverse!
  return errors_from_all_projects
end

def make_pretty_errors_array all_errors
  pretty_array = all_errors.map do |elem|
    {
      title: elem["title"][0..45]+"..",
      err_count: elem["total_occurrences"],
      last_date: Time.at(elem["last_occurrence_timestamp"])
    }
  end
  return pretty_array
end


all_errors = fetch_and_prepare_errors TOKENS, rollbar_fetcher
pretty_last_errors=make_pretty_errors_array all_errors

result_array = []
pretty_last_errors.each do |elem|
  result_array << { label: elem[:title], value: elem[:err_count]}
end


SCHEDULER.every '600s' do
  all_errors = fetch_and_prepare_errors TOKENS, rollbar_fetcher
  pretty_last_errors=make_pretty_errors_array all_errors

  result_array = []
  pretty_last_errors.each do |elem|
    result_array << { label: elem[:title], value: elem[:err_count]}
  end

  send_event('rollbar_errors', { items: result_array })
end

