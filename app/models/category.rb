# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  source_id   :integer
#  name        :string
#  count       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  standard    :boolean
#  language    :string
#  taggs       :string           default("")
#  parent_id   :integer          default(0)
#  feeds_count :integer          default(0)
#  pages_count :integer          default(0)
#

class Category < ApplicationRecord
  
  belongs_to :parent, class_name: 'Category'
  has_many :pages, dependent: :destroy
  validates :name, uniqueness: true
  has_many :children, class_name: 'Category', foreign_key: 'parent_id'

  paginates_per = 99

  def self.exists?(name)
    Category.find_by_name(name) || Category.new
  end
end
