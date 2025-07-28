class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :image, presence: true
  
  # Custom validation for image attachment
  validate :image_format
  validate :image_size
  
  private
  
  def image_format
    return unless image.attached?
    
    acceptable_types = %w[image/png image/jpg image/jpeg image/gif image/webp]
    unless acceptable_types.include?(image.blob.content_type)
      errors.add(:image, 'must be a PNG, JPG, JPEG, GIF, or WEBP file')
    end
  end
  
  def image_size
    return unless image.attached?
    
    if image.blob.byte_size > 5.megabytes
      errors.add(:image, 'must be less than 5MB')
    end
  end
end
