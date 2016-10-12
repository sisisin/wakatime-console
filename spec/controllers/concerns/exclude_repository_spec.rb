require 'rails_helper'
require_relative '../../../app/controllers/concerns/exclude_repository'

describe 'ExcludeRepository' do
  it 'got exclude repos' do
    sut = ExcludeRepository.new

    stub_request(:get, /api.github.com\/orgs\//)
      .to_return(headers: { 'Content-Type':'application/json' }, body: JSON.generate([{ id: 42, name: 'apps' }, { id: 43, name: 'docs' }]))

    expect(sut.get_exclude_repos).to eq (['apps', 'docs']) 
  end
end
