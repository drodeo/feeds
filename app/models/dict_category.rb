# == Schema Information
#
# Table name: dict_categories
#
#  id          :integer          not null, primary key
#  category_id :integer
#  dict        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class DictCategory < ApplicationRecord
end
