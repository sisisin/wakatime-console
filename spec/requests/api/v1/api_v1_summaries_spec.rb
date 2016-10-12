require 'rails_helper'

RSpec.describe "Api::V1::Summaries", type: :request do
  describe "GET /api_v1_summaries" do
    it "works! (now write some real specs)" do
      stub_request(:get, /api.github.com\/orgs\//)
        .to_return(headers: { 'Content-Type':'application/json' }, body: JSON.generate([]))

      get api_v1_summaries_path
      expect(response).to have_http_status(200)
    end
  end
end
