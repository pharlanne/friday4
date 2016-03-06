require ("minitest/autorun")
require_relative("../models/bookmark")
require ("pg")

class TestBookmark < MiniTest::Test

  def setup
    @params={
      "url" => "codeclan.com",
      "title" => "codeclan",
      "category" => "education"
    }

    @bookmark = Bookmark.new(@params)

    @params_search={
      'search'=> 'bbc'
    }

  end

  def test_url_path
    assert_equal("codeclan.com",@bookmark.url)
  end

  def test_find_multi
    result = Bookmark.find_multi(@params_search['search'])
    assert_equal('bbc',result[0].title)
  end

end