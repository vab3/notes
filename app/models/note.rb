class Note < ApplicationRecord
  belongs_to :user
  validates :title, length: { maximum: 30 }
  validates :body, length: { maximum: 1000 },
                   presence: { if: -> { title.blank? },
                     message: "body can't be blank if title is blank" }
  before_validation :default_title

  def formatted_created_at
    zone = ActiveSupport::TimeZone.new('Eastern Time (US & Canada)')
    if(created_at >= 7.days.ago) then
      date = created_at.in_time_zone(zone).strftime('%a')
    else
      date = created_at.in_time_zone(zone).strftime('%a, %b %d, %Y')
    end

    time = created_at.in_time_zone(zone).strftime('%I:%M%P')
    "#{date} #{time}"
  end

  private

  def default_title
    self.title = body[0..30] if title.blank?
  end

end
