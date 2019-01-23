require 'test_helper'

class DistrictsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @district = districts(:one)
  end

  test "should get index" do
    get districts_url, as: :json
    assert_response :success
  end

  test "should create district" do
    assert_difference('District.count') do
      post districts_url, params: { district: { district_num: @district.district_num, name: @district.name, state: @district.state } }, as: :json
    end

    assert_response 201
  end

  test "should show district" do
    get district_url(@district), as: :json
    assert_response :success
  end

  test "should update district" do
    patch district_url(@district), params: { district: { district_num: @district.district_num, name: @district.name, state: @district.state } }, as: :json
    assert_response 200
  end

  test "should destroy district" do
    assert_difference('District.count', -1) do
      delete district_url(@district), as: :json
    end

    assert_response 204
  end
end
