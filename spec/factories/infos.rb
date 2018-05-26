# == Schema Information
#
# Table name: infos
#
#  id         :integer          not null, primary key
#  feed_id    :integer
#  data       :datetime
#  size       :integer
#  page_count :integer
#  tag_count  :integer
#  tagging    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :info do
    
  end
end
