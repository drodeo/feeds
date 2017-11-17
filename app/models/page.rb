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

class Page < ActiveRecord::Base
  belongs_to :feed, touch: true
  validates  :title, presence: true
  validates  :published,  presence: true
  validates :url, uniqueness: true # validates_uniqueness_of :title, conditions: -> { where.not(status: 'archived') }
  acts_as_taggable_on :tags

  self.per_page = 1000

  scope :nodup, -> { where dupl: false }

  #if User.current
 # Chann.where(user_id: User.current.id).each do |s|
  #  scope s.slug.to_sym, -> {where feed_id: s.feed_ids.split(',') }
  #end
 # end
  scope :one, -> { where feed_id: 49 }
  scope :two, -> { where feed_id: 51 }

  def user
   # user ||= User.find_by_id(session[:user_id])
  end

end
