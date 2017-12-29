class Micropost < ApplicationRecord
  belongs_to :user
  scope :sort_desc, ->{order created_at: :desc}
  scope :posted_by, ->(user){where user_id: user.id}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.validates.maximum_content}
  validate :picture_size

  private

    def picture_size
      errors.add(:picture, I18n.t("err_pic_size")) if picture.size > 5.megabytes
    end
end
