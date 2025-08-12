require "test_helper"

class SymptomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get symptoms_index_url
    assert_response :success
  end

  test "should get show" do
    get symptoms_show_url
    assert_response :success
  end
end
