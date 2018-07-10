require 'test_helper'

class SentenceControllerTest < ActionDispatch::IntegrationTest
  test "should get sentiment" do
    get sentence_sentiment_url
    assert_response :success
  end

  test "should get entity" do
    get sentence_entity_url
    assert_response :success
  end

  test "should get token" do
    get sentence_token_url
    assert_response :success
  end

  test "should get category" do
    get sentence_category_url
    assert_response :success
  end

end
