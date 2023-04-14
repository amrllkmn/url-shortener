require 'minitest/autorun'
class UrlsControllerTest < ActionDispatch::IntegrationTest
    test "get #index should return ok" do
        get index_path
        assert_equal(JSON.parse(response.body)["message"], "Hello World!")
        assert_response :success
    end

    test "post #shorten_url status should be created" do
        post shorten_path, params: {url: "https://google.com"}
        resp = JSON.parse(response.body)
        assert_response :created
        assert_not_empty(resp["short_url"])
    end

    test "post #shorten_url should return 422 if url empty" do
        post shorten_path, params: {url: ""}
        resp = JSON.parse(response.body)
        assert_response :unprocessable_entity
        assert_nil resp["short_url"]
    end

    test "post #shorten_url should return 500 if something went wrong" do
        Url.stub :shorten_url, nil do
            post shorten_path, params: {url: "https://google.com"}
            resp = JSON.parse(response.body)
            assert_match(resp["message"], "Something went wrong")
            assert_response :internal_server_error
        end
    end

    test "get #show should be redirected to target_url" do
        fake_location = {"city": "KL", "region": "KL", "country": "MY"}
        url = Url.find(1)
        AbstractApi.stub :get_location, fake_location do
            get "/#{url.slug}"
            assert_redirected_to url.target_url
        end
    end

    test "get #show should return 404 if url is nil" do
        fake_location = {"city": "KL", "region": "KL", "country": "MY"}
        mockAbstract = Minitest::Mock.new
        mockAbstract.expect(:call, fake_location,["127.0.0.1"])
        url = Url.find(1)
        AbstractApi.stub :get_location, mockAbstract do
            Url.stub :update_url, nil do
                get "/#{url.slug}"
                assert_response :not_found
            end
        end
        mockAbstract.verify
    end

    test "get #single_report should return success" do
        url = Url.find(1)
        get "/#{url.id}/report"
        assert_response :success
    end

    test "get #single_report should return 404 if not found" do
        get "/3/report" # ID 3 doesn't exist
        assert_response :not_found
    end
end