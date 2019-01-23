require 'test_helper'

class AppLinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @app_link = app_links(:one)
  end

  test "should get index" do
    get app_links_url, as: :json
    assert_response :success
  end

  test "should create app_link" do
    assert_difference('AppLink.count') do
      post app_links_url, params: { app_link: { description: @app_link.description, icon: @app_link.icon, link: @app_link.link, sort_order: @app_link.sort_order, title: @app_link.title } }, as: :json
    end

    assert_response 201
  end

  test "should show app_link" do
    get app_link_url(@app_link), as: :json
    assert_response :success
  end

  test "should update app_link" do
    patch app_link_url(@app_link), params: { app_link: { description: @app_link.description, icon: @app_link.icon, link: @app_link.link, sort_order: @app_link.sort_order, title: @app_link.title } }, as: :json
    assert_response 200
  end

  test "should destroy app_link" do
    assert_difference('AppLink.count', -1) do
      delete app_link_url(@app_link), as: :json
    end

    assert_response 204
  end
end
