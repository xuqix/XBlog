require 'test_helper'

class ArchivesControllerTest < ActionController::TestCase
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

  test "show should response and render template" do
    response_and_render :show, id: @one
  end
end
