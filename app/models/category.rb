# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  
  belongs_to :parent, class_name: 'Category'
  has_many :pages, dependent: :destroy
  validates :name, uniqueness: true
  has_many :children, class_name: 'Category', foreign_key: 'parent_id'

  paginates_per = 100

  def self.exists?(name)
    Category.find_by_name(name) || Category.new
  end
end
