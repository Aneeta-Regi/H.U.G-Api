require 'test_helper'

class DraRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dra_record = dra_records(:one)
  end

  test "should get index" do
    get dra_records_url, as: :json
    assert_response :success
  end

  test "should create dra_record" do
    assert_difference('DraRecord.count') do
      post dra_records_url, params: { dra_record: { dra_1: @dra_record.dra_1, dra_2: @dra_record.dra_2, dra_3: @dra_record.dra_3, grade: @dra_record.grade, school_year: @dra_record.school_year } }, as: :json
    end

    assert_response 201
  end

  test "should show dra_record" do
    get dra_record_url(@dra_record), as: :json
    assert_response :success
  end

  test "should update dra_record" do
    patch dra_record_url(@dra_record), params: { dra_record: { dra_1: @dra_record.dra_1, dra_2: @dra_record.dra_2, dra_3: @dra_record.dra_3, grade: @dra_record.grade, school_year: @dra_record.school_year } }, as: :json
    assert_response 200
  end

  test "should destroy dra_record" do
    assert_difference('DraRecord.count', -1) do
      delete dra_record_url(@dra_record), as: :json
    end

    assert_response 204
  end
end
