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

require 'rails_helper'

RSpec.describe Info, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
