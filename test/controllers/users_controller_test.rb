require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { background_check: @user.background_check, code_of_ethics: @user.code_of_ethics, commitment_level: @user.commitment_level, emergency_contact_name: @user.emergency_contact_name, emergency_contact_number: @user.emergency_contact_number, image: @user.image, notes: @user.notes, password: @user.password, persona: @user.persona, phone: @user.phone, school_id: @user.school_id, second_phone: @user.second_phone, volunteer_name: @user.volunteer_name } }, as: :json
    end

    assert_response 201
  end

  test "should show user" do
    get user_url(@user), as: :json
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { background_check: @user.background_check, code_of_ethics: @user.code_of_ethics, commitment_level: @user.commitment_level, emergency_contact_name: @user.emergency_contact_name, emergency_contact_number: @user.emergency_contact_number, image: @user.image, notes: @user.notes, password: @user.password, persona: @user.persona, phone: @user.phone, school_id: @user.school_id, second_phone: @user.second_phone, volunteer_name: @user.volunteer_name } }, as: :json
    assert_response 200
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user), as: :json
    end

    assert_response 204
  end
end
