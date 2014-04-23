require 'rest-client'
require 'oj'
class RollbarFetcher
  URL_TEMPLATE="https://api.rollbar.com/api/1/items/?access_token=%s&status=active&level=warning"
  #eed4f2b3576b4a4dac5890abc675d016
  def initialize access_token
    @api_url = URL_TEMPLATE % [access_token]
    @all_errors = []
  end

  def fetch_page page
    url_with_page = @api_url + "&page=#{page}"
    puts url_with_page
    json = RestClient.get(url_with_page)
    data = Oj.load(json)
    return data["result"]["items"]
  end

  def fetch_all
    page = 1
    errors = fetch_page page
    while not errors.empty? do
      @all_errors += errors
      page += 1
      errors = fetch_page page
    end
  end

  def all_errors
    @all_errors
  end
end


