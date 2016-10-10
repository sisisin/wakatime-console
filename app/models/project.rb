class Project < ApplicationRecord
  has_many :editors, dependent: :destroy
  has_many :entities, dependent: :destroy
  has_many :languages, dependent: :destroy
  has_many :operating_systems, dependent: :destroy
  validates :date, presence: true, uniqueness: { scope: [:name] }
  validates :name, presence: true
  validates :total_seconds, presence: true
end
