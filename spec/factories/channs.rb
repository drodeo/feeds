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
