class Project < ApplicationRecord
  has_many :editor, dependent: :destroy
  has_many :entity, dependent: :destroy
  validates :date, presence: true, uniqueness: { scope: [:name] }
  validates :name, presence: true
  validates :total_seconds, presence: true
end
