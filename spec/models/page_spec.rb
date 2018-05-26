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
#  feed_id     :integer          default(0)
#  summary     :string
#  category_id :integer          default(0)
#  image       :string
#  taggs       :string           default("")
#  cnt_match   :integer          default(0)
#  flag_match  :boolean          default(FALSE)
#  dupl        :boolean          default(FALSE)
#  entry_id    :string           default("")
#

require 'rails_helper'

RSpec.describe Page, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
