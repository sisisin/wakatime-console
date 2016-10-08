class Project < ApplicationRecord
  validates :date, presence: true, uniqueness: { scope: [:name] }
  validates :name, presence: true
  validates :total_seconds, presence: true
end
