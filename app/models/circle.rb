class Circle < ApplicationRecord
  has_many :recommendations
  has_many :memberships
end
