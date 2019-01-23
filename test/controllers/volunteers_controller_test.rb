require 'test_helper'

class VolunteersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @volunteer = volunteers(:one)
  end

  test "should get index" do
    get volunteers_url, as: :json
    assert_response :success
  end

  test "should create volunteer" do
    assert_difference('Volunteer.count') do
      post volunteers_url, params: { volunteer: { background_check: @volunteer.background_check, code_of_ethics: @volunteer.code_of_ethics, commitment_level: @volunteer.commitment_level, email: @volunteer.email, emergency_contact_name: @volunteer.emergency_contact_name, emergency_contact_number: @volunteer.emergency_contact_number, image: @volunteer.image, notes: @volunteer.notes, password: @volunteer.password, persona: @volunteer.persona, phone: @volunteer.phone, second_phone: @volunteer.second_phone, volunteer_name: @volunteer.volunteer_name } }, as: :json
    end

    assert_response 201
  end

  test "should show volunteer" do
    get volunteer_url(@volunteer), as: :json
    assert_response :success
  end

  test "should update volunteer" do
    patch volunteer_url(@volunteer), params: { volunteer: { background_check: @volunteer.background_check, code_of_ethics: @volunteer.code_of_ethics, commitment_level: @volunteer.commitment_level, email: @volunteer.email, emergency_contact_name: @volunteer.emergency_contact_name, emergency_contact_number: @volunteer.emergency_contact_number, image: @volunteer.image, notes: @volunteer.notes, password: @volunteer.password, persona: @volunteer.persona, phone: @volunteer.phone, second_phone: @volunteer.second_phone, volunteer_name: @volunteer.volunteer_name } }, as: :json
    assert_response 200
  end

  test "should destroy volunteer" do
    assert_difference('Volunteer.count', -1) do
      delete volunteer_url(@volunteer), as: :json
    end

    assert_response 204
  end
end
