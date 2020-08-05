class Note < ApplicationRecord
  belongs_to :user
  validates :title, length: { maximum: 30 }
  validates :body, length: { maximum: 1000 },
                   presence: { if: -> { title.blank? },
                     message: "body can't be blank if title is blank" }
  before_validation :default_title

  private

  def default_title
    self.title = body[0..30] if title.blank?
  end
end
