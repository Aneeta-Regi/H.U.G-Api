require 'test_helper'

class AveragesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @average = averages(:one)
  end

  test "should get index" do
    get averages_url, as: :json
    assert_response :success
  end

  test "should create average" do
    assert_difference('Average.count') do
      post averages_url, params: { average: { acumen_one: @average.acumen_one, acumen_two: @average.acumen_two, mood_one: @average.mood_one, mood_two: @average.mood_two, student_id: @average.student_id, time_one: @average.time_one, time_two: @average.time_two } }, as: :json
    end

    assert_response 201
  end

  test "should show average" do
    get average_url(@average), as: :json
    assert_response :success
  end

  test "should update average" do
    patch average_url(@average), params: { average: { acumen_one: @average.acumen_one, acumen_two: @average.acumen_two, mood_one: @average.mood_one, mood_two: @average.mood_two, student_id: @average.student_id, time_one: @average.time_one, time_two: @average.time_two } }, as: :json
    assert_response 200
  end

  test "should destroy average" do
    assert_difference('Average.count', -1) do
      delete average_url(@average), as: :json
    end

    assert_response 204
  end
end
