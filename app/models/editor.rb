class Editor < ApplicationRecord
  belongs_to :project
  validates :name, presence: true
  validates :total_seconds, presence: true
end
