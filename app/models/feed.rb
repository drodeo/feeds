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
#  last_update_on_time :integer          default("0")
#

class Feed < ApplicationRecord
  has_many :pages, dependent: :destroy
  #has_many :infos, inverse_of: :source
  #accepts_nested_attributes_for :infos
  validates :url, uniqueness: true
  has_attached_file :icon, styles: { medium: '300x300>', thumb: '100x100>, :png', original: ['500x500>', :png] },
                    convert_options: { thumb: '-quality 75 -strip', medium: '-quality 75 -strip', original: '-quality 85 -strip' },
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :icon, size: { in: 0..500.kilobytes }, content_type: /\Aimage\/.*\Z/
  #has_paper_trail

  scope :rss, -> { where twitter: false }
  scope :tweets, -> {where twitter: true}
  scope :html,-> { where html: true }

  def self.fetch(id)
    Feed.find(id)
  end




  def self.valid_timestamp?(new_timestamp, current_timestamp)
    new_timestamp && new_timestamp.year >= MIN_YEAR &&
        (current_timestamp.nil? || new_timestamp > current_timestamp)
  end
end
