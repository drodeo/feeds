class Chann < ApplicationRecord
  belongs_to :user
  has_many :feeds
  validates :name, uniqueness: true
  self.per_page = 100
end
