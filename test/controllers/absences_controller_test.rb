require 'test_helper'

class AbsencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @absence = absences(:one)
  end

  test "should get index" do
    get absences_url, as: :json
    assert_response :success
  end

  test "should create absence" do
    assert_difference('Absence.count') do
      post absences_url, params: { absence: { date: @absence.date, lesson_id: @absence.lesson_id, lesson_identifier: @absence.lesson_identifier, lesson_name: @absence.lesson_name, student_id: @absence.student_id, vol_name: @absence.vol_name } }, as: :json
    end

    assert_response 201
  end

  test "should show absence" do
    get absence_url(@absence), as: :json
    assert_response :success
  end

  test "should update absence" do
    patch absence_url(@absence), params: { absence: { date: @absence.date, lesson_id: @absence.lesson_id, lesson_identifier: @absence.lesson_identifier, lesson_name: @absence.lesson_name, student_id: @absence.student_id, vol_name: @absence.vol_name } }, as: :json
    assert_response 200
  end

  test "should destroy absence" do
    assert_difference('Absence.count', -1) do
      delete absence_url(@absence), as: :json
    end

    assert_response 204
  end
end
