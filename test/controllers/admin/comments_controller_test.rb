require 'test_helper'

class Admin::CommentsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @one = comments(:one)
  end

  test "comments should +1 count when create" do
    assert_difference 'Comment.count', 1 do
      post :create, article_id: @one.article_id, comment: {commenter: "test", email: "a@gmail.com", content: "abcdefg"}
    end
    assert_redirected_to admin_article_path(@one)
  end

  test "comments should -1 count when destroy" do
    assert_difference 'Comment.count', -1 do
      delete :destroy, article_id: @one.article_id, id: @one.id
    end
    assert_redirected_to admin_article_path(@one)
  end
end
