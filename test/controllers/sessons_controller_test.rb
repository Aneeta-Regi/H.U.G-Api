require 'test_helper'

class SessonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sesson = sessons(:one)
  end

  test "should get index" do
    get sessons_url, as: :json
    assert_response :success
  end

  test "should create sesson" do
    assert_difference('Sesson.count') do
      post sessons_url, params: { sesson: { acumen: @sesson.acumen, first_attempt: @sesson.first_attempt, lesson_id: @sesson.lesson_id, second_attempt: @sesson.second_attempt, student_id: @sesson.student_id, student_mood: @sesson.student_mood, user_id: @sesson.user_id, word_missed: @sesson.word_missed } }, as: :json
    end

    assert_response 201
  end

  test "should show sesson" do
    get sesson_url(@sesson), as: :json
    assert_response :success
  end

  test "should update sesson" do
    patch sesson_url(@sesson), params: { sesson: { acumen: @sesson.acumen, first_attempt: @sesson.first_attempt, lesson_id: @sesson.lesson_id, second_attempt: @sesson.second_attempt, student_id: @sesson.student_id, student_mood: @sesson.student_mood, user_id: @sesson.user_id, word_missed: @sesson.word_missed } }, as: :json
    assert_response 200
  end

  test "should destroy sesson" do
    assert_difference('Sesson.count', -1) do
      delete sesson_url(@sesson), as: :json
    end

    assert_response 204
  end
end
