require 'rails_helper'

RSpec.describe OperatingSystem, type: :model do
  it { should belong_to(:project)}
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:total_seconds) }
end
