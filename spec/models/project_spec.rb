require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should have_many(:editors)}
  it { should have_many(:entities)}
  it { should have_many(:languages)}
  it { should have_many(:operating_systems)}
  it { should validate_presence_of(:date) }
  it { should validate_uniqueness_of(:date).scoped_to(:name) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:total_seconds) }
end
