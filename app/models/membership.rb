class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :circle
  has_many :recommendations
end
