require 'test_helper'

class AnalyseControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get analyse_index_url
    assert_response :success
  end

end
