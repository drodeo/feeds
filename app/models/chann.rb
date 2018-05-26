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

class Chann < ApplicationRecord
  belongs_to :user
#  has_many :feeds
end
