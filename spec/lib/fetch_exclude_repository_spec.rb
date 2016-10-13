require 'rails_helper'
require_relative '../../lib/fetch_exclude_repository'

describe 'FetchExcludeRepository' do
  sut = FetchExcludeRepository.new

  before(:each) do
    stub_request(:get, /api.github.com\/orgs\//)
      .to_return(headers: { 'Content-Type':'application/json' }, body: JSON.generate([{ id: 42, name: 'apps' }, { id: 43, name: 'docs' }]))
  end

  after(:each) { WebMock.reset! }
  
  it 'got exclude repos' do
    expect(sut.fetch_exclude_repos).to eq (['apps', 'docs']) 
  end

  it 'saved orgs repo names' do
    sut.save
    expect(ExcludeRepository.first.names).to eq ['apps', 'docs']
  end

  it 'updated orgs repo names' do
    ExcludeRepository.create(names: ['first'])
    sut.save
    expect(ExcludeRepository.first.names).to eq ['apps', 'docs']
  end
end
