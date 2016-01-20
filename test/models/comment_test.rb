require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @article = articles(:one)
    # 这行代码不符合常见做法
    @comment = @article.comments.build(commenter: "test", email: "test@gmail.com",
                                      content: "hello comment")
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "email can be nil or blank" do
    @comment.email = nil
    assert @comment.valid?
    @comment.email = ''
    assert @comment.valid?
  end

  test "email should not too long" do
    @comment.email = 'a' * 256 + '@ex.com'
    assert_not @comment.valid?
  end

  test "article id should be present" do
    @comment.article_id = nil
    assert_not @comment.valid?
  end

  test "content should be present" do
    @comment.content = "   "
    assert_not @comment.valid?
  end

  test "commenter should be present" do
    @comment.commenter = "   "
    assert_not @comment.valid?
  end

  test "content should not too long " do
    @comment.content = "a" * 65536
    assert_not @comment.valid?
  end

  test "commenter should not too long " do
    @comment.commenter = "a" * 256
    assert_not @comment.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
      foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @comment.email = invalid_address
        assert_not @comment.valid?, "#{invalid_address.inspect} should be invalid"
      end
    end
end
