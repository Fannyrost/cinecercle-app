class Invitation < ApplicationRecord
  belongs_to :circle
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User', optional: true

  def generate_token
   self.token = Digest::SHA1.hexdigest([self.circle_id, Time.now, rand].join)
  end
end
