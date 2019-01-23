require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @session = sessions(:one)
  end

  test "should get index" do
    get sessions_url, as: :json
    assert_response :success
  end

  test "should create session" do
    assert_difference('Session.count') do
      post sessions_url, params: { session: { lesson_id: @session.lesson_id, recorded_by: @session.recorded_by, student_id: @session.student_id, student_mood: @session.student_mood, time: @session.time, word_missed: @session.word_missed } }, as: :json
    end

    assert_response 201
  end

  test "should show session" do
    get session_url(@session), as: :json
    assert_response :success
  end

  test "should update session" do
    patch session_url(@session), params: { session: { lesson_id: @session.lesson_id, recorded_by: @session.recorded_by, student_id: @session.student_id, student_mood: @session.student_mood, time: @session.time, word_missed: @session.word_missed } }, as: :json
    assert_response 200
  end

  test "should destroy session" do
    assert_difference('Session.count', -1) do
      delete session_url(@session), as: :json
    end

    assert_response 204
  end
end
