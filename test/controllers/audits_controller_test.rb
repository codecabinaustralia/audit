require 'test_helper'

class AuditsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @audit = audits(:one)
  end

  test "should get index" do
    get audits_url
    assert_response :success
  end

  test "should get new" do
    get new_audit_url
    assert_response :success
  end

  test "should create audit" do
    assert_difference('Audit.count') do
      post audits_url, params: { audit: { department: @audit.department, description: @audit.description, title: @audit.title, user_id: @audit.user_id } }
    end

    assert_redirected_to audit_url(Audit.last)
  end

  test "should show audit" do
    get audit_url(@audit)
    assert_response :success
  end

  test "should get edit" do
    get edit_audit_url(@audit)
    assert_response :success
  end

  test "should update audit" do
    patch audit_url(@audit), params: { audit: { department: @audit.department, description: @audit.description, title: @audit.title, user_id: @audit.user_id } }
    assert_redirected_to audit_url(@audit)
  end

  test "should destroy audit" do
    assert_difference('Audit.count', -1) do
      delete audit_url(@audit)
    end

    assert_redirected_to audits_url
  end
end
