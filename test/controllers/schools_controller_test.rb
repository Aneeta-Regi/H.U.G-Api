require 'test_helper'

class SchoolsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @school = schools(:one)
  end

  test "should get index" do
    get schools_url, as: :json
    assert_response :success
  end

  test "should create school" do
    assert_difference('School.count') do
      post schools_url, params: { school: { clarity_person_email: @school.clarity_person_email, clarity_person_name: @school.clarity_person_name, clarity_person_phone: @school.clarity_person_phone, clarity_person_second_phone: @school.clarity_person_second_phone, notes: @school.notes, principal_name: @school.principal_name, school_city: @school.school_city, school_district: @school.school_district, school_name: @school.school_name, school_phone: @school.school_phone, school_state: @school.school_state, school_zip: @school.school_zip, vice_principal_name: @school.vice_principal_name } }, as: :json
    end

    assert_response 201
  end

  test "should show school" do
    get school_url(@school), as: :json
    assert_response :success
  end

  test "should update school" do
    patch school_url(@school), params: { school: { clarity_person_email: @school.clarity_person_email, clarity_person_name: @school.clarity_person_name, clarity_person_phone: @school.clarity_person_phone, clarity_person_second_phone: @school.clarity_person_second_phone, notes: @school.notes, principal_name: @school.principal_name, school_city: @school.school_city, school_district: @school.school_district, school_name: @school.school_name, school_phone: @school.school_phone, school_state: @school.school_state, school_zip: @school.school_zip, vice_principal_name: @school.vice_principal_name } }, as: :json
    assert_response 200
  end

  test "should destroy school" do
    assert_difference('School.count', -1) do
      delete school_url(@school), as: :json
    end

    assert_response 204
  end
end
