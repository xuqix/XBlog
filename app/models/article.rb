class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { maximum: 64 }
  validates :content, presence: true, length: { maximum: 65535 }
end
