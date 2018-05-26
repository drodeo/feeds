# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  source_id   :integer
#  name        :string
#  count       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  standard    :boolean
#  language    :string
#  taggs       :string           default("")
#  parent_id   :integer          default(0)
#  feeds_count :integer          default(0)
#  pages_count :integer          default(0)
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
