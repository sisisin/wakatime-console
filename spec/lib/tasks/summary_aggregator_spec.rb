require "rails_helper"
require_relative '../../../lib/tasks/summary_aggregator'
require 'date'
require 'json'

describe 'SummaryAggregator' do
  it "fetch wakatime success" do
    wakatime_fixture = open('spec/fixtures/files/wakatime_response.json') { |f| JSON.load(f) }
    response_json = SummaryAggregator.new.fetch(Date.new(2016, 9, 22))

    expect(wakatime_fixture).to eq response_json
  end
end
