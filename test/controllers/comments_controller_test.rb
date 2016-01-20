require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @one = comments(:one)
  end

  test "comments should +1 count when create" do
    assert_difference 'Comment.count', 1 do
      post :create, archive_id: @one.article_id, comment: {commenter: "test", email: "a@gmail.com", content: "abcdefg"}
    end
    assert_redirected_to archive_path(@one)
  end
end
