require 'rest-client'
require 'oj'
class RollbarFetcher
  URL_TEMPLATE="https://api.rollbar.com/api/1/items/?access_token=%s&status=active&level=warning"


  def fetch_page page, access_token
    url_with_page = URL_TEMPLATE % access_token + "&page=#{page}"
    puts url_with_page
    json = RestClient.get(url_with_page)
    data = Oj.load(json)
    return data["result"]["items"]
  end

  def apply_conditions! all_errors
    return all_errors.map{|elem| elem if elem["level"] == "error"}.compact
  end

  def fetch_all access_token
    all_errors = []
    page = 1
    errors = fetch_page page, access_token
    while not errors.empty? do
      all_errors += errors
      page += 1
      errors = fetch_page page, access_token
    end
    all_errors = apply_conditions! all_errors
    return all_errors
  end

end


