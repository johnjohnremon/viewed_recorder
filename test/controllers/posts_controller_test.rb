require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get posts_index_url
    assert_response :success
  end

  test "should filtering" do
    get posts_index_url
    assert_select ".posts-index-item", 3
    post posts_index_url, params: {filter: "title", keyword: "MyTitle"}
    assert_select ".posts-index-item", 2
    assert_select ".title_for_test", "MyTitle"
    assert_select ".filter_keyword input[value='MyTitle']"
    assert_select ".filter_option input[value='title'][checked]"
    post posts_index_url, params: {filter: "site", keyword: "hoge"}
    assert_select ".posts-index-item", 1
    assert_select ".site_for_test", "hoge"
    assert_select ".filter_option input[value='site'][checked]"
    post posts_index_url, params: {filter: "assess", keyword: "4"}
    assert_select ".posts-index-item", 2
    assert_select "#star2[checked]", 2
    assert_select ".filter_option input[value='assess'][checked]"
    post posts_index_url, params: {filter: "title", keyword: "helloworld"}
    assert_select ".posts-index-item", 0
  end

end
