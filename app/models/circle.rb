class Circle < ApplicationRecord
  has_many :recommendations
  has_many :memberships
  has_many :users, through: :memberships
  has_many :invitations
end
