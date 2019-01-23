require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = students(:one)
  end

  test "should get index" do
    get students_url, as: :json
    assert_response :success
  end

  test "should create student" do
    assert_difference('Student.count') do
      post students_url, params: { student: { dra_score_1: @student.dra_score_1, dra_score_2: @student.dra_score_2, dra_score_3: @student.dra_score_3, first_name: @student.first_name, image: @student.image, last_name: @student.last_name, notes: @student.notes, school_id: @student.school_id, school_name: @student.school_name, volunteer_id: @student.volunteer_id } }, as: :json
    end

    assert_response 201
  end

  test "should show student" do
    get student_url(@student), as: :json
    assert_response :success
  end

  test "should update student" do
    patch student_url(@student), params: { student: { dra_score_1: @student.dra_score_1, dra_score_2: @student.dra_score_2, dra_score_3: @student.dra_score_3, first_name: @student.first_name, image: @student.image, last_name: @student.last_name, notes: @student.notes, school_id: @student.school_id, school_name: @student.school_name, volunteer_id: @student.volunteer_id } }, as: :json
    assert_response 200
  end

  test "should destroy student" do
    assert_difference('Student.count', -1) do
      delete student_url(@student), as: :json
    end

    assert_response 204
  end
end
