require "test_helper"

class CommunicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get communications_index_url
    assert_response :success
  end

  test "should get new" do
    get communications_new_url
    assert_response :success
  end

  test "should get create" do
    get communications_create_url
    assert_response :success
  end
end
