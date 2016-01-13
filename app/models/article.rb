class Article < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 64 }
  validates :text, presence: true, length: { maximum: 65535 }
end
