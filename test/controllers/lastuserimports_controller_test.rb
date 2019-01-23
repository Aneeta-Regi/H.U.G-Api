require 'test_helper'

class LastuserimportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lastuserimport = lastuserimports(:one)
  end

  test "should get index" do
    get lastuserimports_url, as: :json
    assert_response :success
  end

  test "should create lastuserimport" do
    assert_difference('Lastuserimport.count') do
      post lastuserimports_url, params: { lastuserimport: { group_id: @lastuserimport.group_id, member_id: @lastuserimport.member_id } }, as: :json
    end

    assert_response 201
  end

  test "should show lastuserimport" do
    get lastuserimport_url(@lastuserimport), as: :json
    assert_response :success
  end

  test "should update lastuserimport" do
    patch lastuserimport_url(@lastuserimport), params: { lastuserimport: { group_id: @lastuserimport.group_id, member_id: @lastuserimport.member_id } }, as: :json
    assert_response 200
  end

  test "should destroy lastuserimport" do
    assert_difference('Lastuserimport.count', -1) do
      delete lastuserimport_url(@lastuserimport), as: :json
    end

    assert_response 204
  end
end
