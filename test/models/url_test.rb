require "test_helper"

class UrlTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Creating a URL with no slug should create a slug" do
    url = Url.create(target_url: "https://google.com", slug:"")
    assert !url.slug.empty?
  end

  test "Creating a URL with a slug should return same slug" do
    test_slug = "testing"
    url = Url.create(target_url: "https://google.com", slug: test_slug)
    assert url.slug == test_slug
  end

  test "Creating 2 URLs with same slug should not be created" do
    url_1_slug = Url.find(1).slug
    url_2 = Url.create(target_url: "https://google.com", slug: url_1_slug)
    assert url_2.id.nil?
  end

  test "Creating URL without https should not be created" do
    url = Url.create(target_url: "www.google.com")
    assert url.id.nil?
  end


  test "shorten_url should return a string url" do
    url = Url.shorten_url("https://google.com","","test.com")
    assert !url.empty?
  end

  test "shorten_url should return url with existing slug" do
    url_1_slug = Url.find(1).slug
    new_url = Url.shorten_url("https://youtube.com", url_1_slug, "test.com")
    new_slug = new_url.split("/")[-1]
    assert Url.find_by(slug: new_slug).target_url == "https://google.com"
  end

  test "update_url should increment clicks and click_timestamp and origin" do
    url_1 = Url.find(1)
    geolocation = {"city": "Kuala Lumpur", "region": "Kuala Lumpur", "country": "Malaysia"}
    updated_url = Url.update_url(url_1.slug, geolocation)
    assert updated_url.times_clicked == 2
    assert JSON.parse(updated_url.origin).length == 2
    assert JSON.parse(updated_url.click_timestamp).keys.length == 2
  end

  test "update_url should return nil if not found" do
    geolocation = {"city": "Kuala Lumpur", "region": "Kuala Lumpur", "country": "Malaysia"}
    updated_url = Url.update_url("non_existing", geolocation)
    assert updated_url.nil?
  end

  test "get_report should return data if url found" do
    report = Url.get_report(1) # get Url with ID 1
    assert !report.nil?
  end

  test "get_report should return nil if url not found" do
    report = Url.get_report(5) # get Url with ID 5 which don't exist
    assert report.nil?
  end
end
