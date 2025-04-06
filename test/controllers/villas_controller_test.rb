require "test_helper"

class VillasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get villas_index_url
    assert_response :success
  end

  test "should get availability" do
    get villas_availability_url
    assert_response :success
  end
end
