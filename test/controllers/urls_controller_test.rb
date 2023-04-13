class UrlsControllerTest < ActionDispatch::IntegrationTest
    test "should get index" do
        get index_path
        assert_equal(JSON.parse(response.body)["message"], "Hello World!")
        assert_response :success
    end

    test "post shorten url status should be created" do
        post shorten_path, params: {url: "https://google.com"}
        resp = JSON.parse(response.body)
        assert_response :created

    end
end