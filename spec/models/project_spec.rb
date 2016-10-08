require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should have_many(:editor)}
  it { should have_many(:entity)}
  it { should have_many(:language)}
  it { should have_many(:operating_system)}
  it { should validate_presence_of(:date) }
  it { should validate_uniqueness_of(:date).scoped_to(:name) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:total_seconds) }
end
