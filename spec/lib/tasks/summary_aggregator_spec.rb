require "rails_helper"
require_relative '../../../lib/tasks/summary_aggregator'
require 'date'
require 'json'
require 'webmock/rspec'


describe 'SummaryAggregator' do
  describe "fetch wakatime success" do
    after do
      WebMock.reset!
    end
    it "with params" do
      target_date = Date.new(2016, 9, 22)
      wakatime_fixture = open('spec/fixtures/files/wakatime_response.json') { |f| JSON.load(f) }

      stub_request(:get, /wakatime.com\/api\/v1\/users\/52f058ec-e04e-436b-906d-eff6c461abf5\/summaries.*/)
        .with(query: {
          start: target_date.to_s,
          end: target_date.to_s,
          project: 'wakatime-console',
          api_key: ENV['WAKATIME_API_KEY']
        })
        .to_return(body: JSON.generate(wakatime_fixture))

      expect(SummaryAggregator.new.fetch(target_date)).to eq wakatime_fixture
    end
  end
end
