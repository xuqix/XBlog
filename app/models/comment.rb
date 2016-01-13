class EmailValidator < ActiveModel::EachValidator
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "is not an email") unless
      value.nil? || value.empty? || value =~ VALID_EMAIL_REGEX
  end
end

class Comment < ActiveRecord::Base
  belongs_to :article

  validates :article_id, presence: true
  validates :commenter, presence: true, length: {maximum: 255}
  validates :content, presence: true, length: {maximum: 65535}
  validates :email, length: {maximum: 255}, email: true
end
