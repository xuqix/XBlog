require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  def setup
    @one = comments(:one)
  end

  test "comments should +1 count when create" do
    assert_difference 'Comment.count', 1 do
      post :create, article_id: @one.article_id, comment: {commenter: "test", email: "a@gmail.com", content: "abcdefg"}
    end
    assert_redirected_to article_path(@one)
  end

  test "comments should -1 count when destroy" do
    assert_difference 'Comment.count', -1 do
      delete :destroy, article_id: @one.article_id, id: @one.id
    end
    assert_redirected_to article_path(@one)
  end
end
