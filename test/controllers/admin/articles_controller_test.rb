require 'test_helper'

class Admin::ArticlesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @one = articles(:one)
    @two = articles(:two)
  end

  def response_and_render(routes_name, **opt)
    get routes_name.to_sym, id: opt[:id]
    assert_response :success
    assert_template routes_name.to_sym
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
      post :create, article: { title: 'test title', content: 'test text'}
    end
  end

  test "update should success and redirect" do
    patch :update, id: @one, article: { title: "patch title", content: "patch text"}
    assert_redirected_to [:admin, @one]
  end

  test "destroy should success and redirect to index" do
    assert_difference 'Article.count', -1 do
      delete :destroy, id: @one
    end
    assert_redirected_to admin_articles_path
  end
end
