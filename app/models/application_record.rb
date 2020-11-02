class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def time_ago
    now = Time.now
    time_ago = TimeDifference.between(self.created_at, now).in_seconds
    case time_ago
    when 0..119        then "à l'instant"
    when 120..3599     then "il y a #{(time_ago / 60).round} minutes"
    when 3600..86399   then "il y a #{(time_ago / 3600).round} heures"
    when 86400..604800 then "il y a #{(time_ago / 86400).round} jours"
    else "il y a #{(TimeDifference.between(self.created_at, now).in_weeks).round} semaines"
    end
  end
end
