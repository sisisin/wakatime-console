require 'httpclient'
require 'date'
require 'json'

class SummaryAggregator
  def fetch(target_date = Date::today - 1, project = 'wakatime-console')
    api_key=ENV['WAKATIME_API_KEY']
    raise 'Invalid nil enviroment variable "WAKATIME_API_KEY".' if api_key.nil?

    client = HTTPClient.new
    # client.debug_dev = $stderr

    query = {
      start: target_date.to_s,
      end: target_date.to_s,
      project: project,
      api_key: api_key
    }
    uri = 'https://wakatime.com/api/v1/users/52f058ec-e04e-436b-906d-eff6c461abf5/summaries'
    body = client.get(uri, query).body
    JSON.load(body)
  end
end
