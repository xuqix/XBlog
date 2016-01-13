require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @one = articles(:one)
    @two = articles(:two)
    @temp = Article.new(title: 'title', text: 'text')
  end

  def response_and_render(routes_name, **opt)
    get routes_name.to_sym, id: opt[:id]
    assert_response :success
    assert_template routes_name.to_sym
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

  test "index should response and render template" do
    response_and_render :index
  end

  test "new should response and render template" do
    response_and_render :new
  end

  test "edit should response and render template" do
    response_and_render :edit, id: @one
  end

  test "show should response and render template" do
    response_and_render :show, id: @one
  end

  test "create should success and redirect to show" do
    assert_difference 'Article.count', 1 do
      post :create, article: { title: 'test title', text: 'test text'}
    end
  end

  test "update should success and redirect" do
    patch :update, id: @one, article: { title: "patch title", text: "patch text"}
    assert_redirected_to @one
  end

  test "destroy should success and redirect to index" do
    assert_difference 'Article.count', -1 do
      delete :destroy, id: @one
    end
    assert_redirected_to articles_path
  end
end
