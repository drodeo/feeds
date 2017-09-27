class Info < ApplicationRecord
  belongs_to :feed, inverse_of: :infos
end
