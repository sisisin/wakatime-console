require "rails_helper"
require_relative '../../../lib/tasks/summary_aggregator'
require 'date'
require 'json'
require 'webmock/rspec'


describe 'SummaryAggregator' do
  target_date = Date.new(2016, 9, 22)
  wakatime_fixture = open('spec/fixtures/files/wakatime_response.json') { |f| JSON.load(f) }
  project = "wakatime-console"
  base_query = {
    start: target_date.to_s,
    end: target_date.to_s,
    api_key: ENV['WAKATIME_API_KEY']
  } 

  describe "fetch_project_summary wakatime success" do
    after { WebMock.reset! }

    it "with params" do
      stub_request(:get, /wakatime.com\/api\/v1\/users\/52f058ec-e04e-436b-906d-eff6c461abf5\/summaries.*/)
        .with(query: base_query.merge(project: project))
        .to_return(body: JSON.generate(wakatime_fixture))

      expect(SummaryAggregator.new.fetch_project_summary(target_date)).to eq wakatime_fixture
    end
  end

  describe "save" do
    before(:each) do
      stub_request(:get, /wakatime.com\/api\/v1\/users\/52f058ec-e04e-436b-906d-eff6c461abf5\/summaries.*project=wakatime-console*/)
        .to_return(body: JSON.generate(wakatime_fixture))
      SummaryAggregator.new.save(target_date, project)
    end

    after(:each) { WebMock.reset! }

    it "create project that named by argument" do
      expect(Project.first.name).to eq project
    end

    it "create project that has total_seconds by response" do
      expect(Project.first.total_seconds).to eq wakatime_fixture['data'].first['grand_total']['total_seconds']
    end

    it "create project that has target_date" do
      expect(Project.first.date).to eq target_date
    end

    it "create editor that has name by resopnse" do
      expect(Editor.first.name).to eq wakatime_fixture['data'].first['editors'].first['name']
    end

    it "create editor that has total_seconds by resopnse" do
      expect(Editor.first.total_seconds).to eq wakatime_fixture['data'].first['editors'].first['total_seconds']
    end
    
    it "create entities that has 13 data" do
      expect(Entity.all.size).to eq wakatime_fixture['data'].first['entities'].size
    end

    it "create languages that has 4 data" do
      expect(Language.all.size).to eq wakatime_fixture['data'].first['languages'].size
    end

    it "create operating_system that has 1 data" do
      expect(OperatingSystem.all.size).to eq wakatime_fixture['data'].first['operating_systems'].size
    end
  end
end
