require 'httpclient'
require 'date'
require 'json'

class SummaryAggregator
  # todo fetch projects and aggregate there.

  def fetch_project_summary(target_date = Date::today - 1, project)
    fetch_wakatime(start: target_date.to_s, end: target_date.to_s, project: project)
  end

  def fetch_projects(target_date = Date::today - 1)
    fetch_wakatime(start: target_date.to_s, end: target_date.to_s)
  end

  def save_all(target_date = Date::today - 1)
    projects = fetch_projects(target_date)['data'].first['projects']
    projects.each { |prj| save(target_date, prj['name']) }
  end

  def save(target_date = Date::today - 1, project)
    data = fetch_project_summary(target_date, project)['data'].first
    total_seconds = data['grand_total']['total_seconds']
    project = Project.create!(date: target_date, name: project, total_seconds: total_seconds)

    %w`editors entities languages operating_systems`
      .map { |sym| data[sym].map { |e| project.send(sym).build(get_model_entity(e)) } }
    project.save
  end

  private
  def get_model_entity(e)
    { name: e['name'], total_seconds: e['total_seconds'] }
  end

  def fetch_wakatime(query)
    api_key=ENV['WAKATIME_API_KEY']
    raise 'Invalid nil enviroment variable "WAKATIME_API_KEY".' unless api_key

    client = HTTPClient.new
    # client.debug_dev = $stderr
    uri = 'https://wakatime.com/api/v1/users/52f058ec-e04e-436b-906d-eff6c461abf5/summaries'
    res = client.get(uri, query.merge(api_key: api_key))
    body = res.body
    JSON.load(body)
  end
end
