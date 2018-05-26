# == Schema Information
#
# Table name: channs
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  name               :string
#  feed_id            :integer
#  email_notification :boolean
#  email_period       :integer
#  tgram_notification :boolean
#  tgram_period       :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  slug               :string
#  feed_ids           :string
#

FactoryGirl.define do
  factory :chann do
    user_id 1
    name "MyString"
    feed_id 1
    email_notification false
    email_period 1
    tgram_notification false
    tgram_period 1
  end
end
