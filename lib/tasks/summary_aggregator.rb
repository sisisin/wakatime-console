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

  def save(target_date = Date::today - 1, project)
    data = fetch_project_summary(target_date, project)['data'].first
    total_seconds = data['grand_total']['total_seconds']
    project = Project.create(date: target_date, name: project, total_seconds: total_seconds)

    Editor.import data['editors'].map { |e| project.editor.build(get_model_entity(e)) }
    Entity.import data['entities'].map { |e| project.entity.build(get_model_entity(e)) }
    Language.import data['languages'].map { |e| project.language.build(get_model_entity(e)) }
    OperatingSystem.import data['operating_systems'].map { |e| project.operating_system.build(get_model_entity(e)) }
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
