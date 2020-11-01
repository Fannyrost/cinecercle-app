class Recommendation < ApplicationRecord
  belongs_to :movie
  belongs_to :circle
  belongs_to :membership

end
