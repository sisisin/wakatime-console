require "rails_helper"
require_relative '../../../lib/tasks/summary_aggregator'
require 'date'
require 'json'
require 'webmock/rspec'


describe 'SummaryAggregator' do
  target_date = Date.new(2016, 9, 22)
  project_a_fixture = open('spec/fixtures/files/wt_res_project_a.json') { |f| JSON.load(f) }
  project_b_fixture = open('spec/fixtures/files/wt_res_project_b.json') { |f| JSON.load(f) }
  projects_fixture = open('spec/fixtures/files/wt_res_projects.json') { |f| JSON.load(f) }
  project_a = "project_a"
  base_query = {
    start: target_date.to_s,
    end: target_date.to_s,
    api_key: ENV['WAKATIME_API_KEY']
  } 

  describe "fetch_project_summary wakatime success" do
    after { WebMock.reset! }

    it "with params" do
      stub_request(:get, /wakatime.com\/api\/v1\/users\/52f058ec-e04e-436b-906d-eff6c461abf5\/summaries.*/)
        .with(query: base_query.merge(project: project_a))
        .to_return(body: JSON.generate(project_a_fixture))

      expect(SummaryAggregator.new.fetch_project_summary(target_date, project_a)).to eq project_a_fixture
    end
  end

  describe "fetch_projects success" do
    after { WebMock.reset! }

    it "with params" do
      stub_request(:get, /wakatime.com\/api\/v1\/users\/52f058ec-e04e-436b-906d-eff6c461abf5\/summaries.*/)
        .with(query: base_query)
        .to_return(body: JSON.generate(projects_fixture))

      expect(SummaryAggregator.new.fetch_projects(target_date)).to eq projects_fixture
    end
  end

  describe "save" do
    before(:each) do
      stub_request(:get, /wakatime.com\/api\/v1\/users\/52f058ec-e04e-436b-906d-eff6c461abf5\/summaries.*project=project_a*/)
        .to_return(body: JSON.generate(project_a_fixture))
      SummaryAggregator.new.save(target_date, project_a)
    end

    after(:each) { WebMock.reset! }

    it "create project that named by argument" do
      expect(Project.first.name).to eq project_a
    end

    it "create project that has total_seconds by response" do
      expect(Project.first.total_seconds).to eq project_a_fixture['data'].first['grand_total']['total_seconds']
    end

    it "create project that has target_date" do
      expect(Project.first.date).to eq target_date
    end

    it "create editor that has name by resopnse" do
      expect(Editor.first.name).to eq project_a_fixture['data'].first['editors'].first['name']
    end

    it "create editor that has total_seconds by resopnse" do
      expect(Editor.first.total_seconds).to eq project_a_fixture['data'].first['editors'].first['total_seconds']
    end
    
    it "create entities that has 13 data" do
      expect(Entity.all.size).to eq project_a_fixture['data'].first['entities'].size
    end

    it "create languages that has 4 data" do
      expect(Language.all.size).to eq project_a_fixture['data'].first['languages'].size
    end

    it "create operating_system that has 1 data" do
      expect(OperatingSystem.all.size).to eq project_a_fixture['data'].first['operating_systems'].size
    end
  end

  describe "save_all" do
    before(:each) do
      stub_request(:get, /wakatime.com\/api\/v1\/users\/52f058ec-e04e-436b-906d-eff6c461abf5\/summaries.*/)
        .with(query: base_query)
        .to_return(body: JSON.generate(projects_fixture))

      stub_request(:get, /wakatime.com\/api\/v1\/users\/52f058ec-e04e-436b-906d-eff6c461abf5\/summaries.*project=project_a*/)
        .to_return(body: JSON.generate(project_a_fixture))

      stub_request(:get, /wakatime.com\/api\/v1\/users\/52f058ec-e04e-436b-906d-eff6c461abf5\/summaries.*project=project_b*/)
        .to_return(body: JSON.generate(project_b_fixture))

      SummaryAggregator.new.save_all(target_date)
    end

    after(:each) { WebMock.reset! }

    it "create projects from projects response" do
      expect(Project.all.size).to eq projects_fixture['data'].first['projects'].size
    end

    it "create project_a" do
      expect(Project.first.name).to eq projects_fixture['data'].first['projects'].first['name']
    end

    it "create project_b" do
      expect(Project.last.name).to eq projects_fixture['data'].first['projects'].last['name']
    end
  end
end
