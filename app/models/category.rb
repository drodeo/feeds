# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  has_many :pages, dependent: :destroy
  validates :name, uniqueness: true

  def self.exists?(name)
    Category.find_by_name(name) || Category.new
  end
end
