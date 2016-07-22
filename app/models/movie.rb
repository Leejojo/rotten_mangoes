class Movie < ApplicationRecord

  has_many :reviews
  mount_uploader :image, ImageUploader
  
  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :poster_image_url,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  scope :less_than_90, -> { where("runtime_in_minutes < ? ", 90) }
  scope :between, -> { where("runtime_in_minutes >= ? AND runtime_in_minutes <= ? ", 90, 120)}
  scope :greater_than_120, -> { where("runtime_in_minutes > ? ", 120)}

  def review_average
    reviews.average(:rating_out_of_ten)
  end
      
  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
  
end
