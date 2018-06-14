# == Schema Information
#
# Table name: feeds
#
#  id                  :integer          not null, primary key
#  name                :string
#  url                 :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  icon_file_name      :string
#  icon_content_type   :string
#  icon_file_size      :integer
#  icon_updated_at     :datetime
#  count               :integer
#  type                :text
#  html                :boolean
#  source              :string
#  last_update_on_time :integer          default(0)
#  last_fetched        :datetime
#  standard            :boolean
#  parent              :integer          default(0)
#  language            :string
#  taggs               :string           default("")
#  twitter             :boolean          default(FALSE)
#  pages_count         :integer          default(0)
#  page_id             :integer
#

FactoryBot.define do
  factory :feed do
    
  end
end
