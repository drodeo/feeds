# == Schema Information
#
# Table name: pages
#
#  id          :integer          not null, primary key
#  title       :string
#  url         :string
#  published   :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  feed_id     :integer          default("0")
#  summary     :string
#  category_id :integer          default("0")
#  image       :string
#  taggs       :string           default("")
#  cnt_match   :integer          default("0")
#  flag_match  :boolean          default("false")
#  dupl        :boolean          default("false")
#

FactoryGirl.define do
  factory :page do
    
  end
end
