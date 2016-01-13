require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @temp = Article.new(title: 'title', text: 'text')
  end

  test "title should be present" do
    @temp.title = '   '
    assert_not @temp.valid?
  end

  test "text should be present" do
    @temp.text = '   '
    assert_not @temp.valid?
  end

  test "title should not too long" do
    @temp.title = 'a' * 65
    assert_not @temp.valid?
  end

  test "text should not too long" do
    @temp.text = 'a' * 65536
    assert_not @temp.valid?
  end
end
