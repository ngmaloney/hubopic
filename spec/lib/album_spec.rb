require_relative "../test_helper"

describe Album do
  before do
    @album = Album.new("poms", OpenStruct.new(host: "http://www.example.com"))
  end

  describe "::list" do
    before do
      @list = Album.list
    end

    it "contains photos" do
      @list.wont_be_empty
      @list.must_include "poms"
    end
  end

  describe "#random" do
    it "returns a photo" do
      @album.random.wont_be_empty
      @album.random.size.must_equal 1
    end

    it "returns multiple photos" do
      @album.random(3).wont_be_empty
      @album.random(3).size.must_equal 3
    end
  end

  describe "#path" do
    it "returns the path" do
      @album.path.must_equal "images/poms"
    end
  end

  describe "#images" do
    it "returns a list of images" do
      @album.images.wont_be_empty
      @album.images.must_include "http://www.example.com/images/poms/1951ffa8ec7f06b81d8bc6794adfdc1e.jpg"
    end
  end
end
