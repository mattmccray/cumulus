require File.dirname(__FILE__) + '/../test_helper.rb'

class HashDbTest < Test::Unit::TestCase

  context "HashDB" do 
    
    setup do
      #@db = Cumulus::HashDb.new
      Cumulus::Scanner.new("#{ File.dirname(__FILE__) }/../fixtures/my_site").sweep
    end
    
    should "have found some content collections" do
      assert_not_equal(0, Cumulus::Resources.collections(:collection_type=>'posts').length)
    end
    
    # should "support wildcard searchs" do
    #   all = Cumulus::Resources.collections.length
    #   articles = Cumulus::Resources.collections(:content_path=>'articles/*').length
    #   assert_not_equal(0, articles)
    #   assert_not_equal(all, articles)
    #   
    #   star_all = Cumulus::Resources.collections(:content_path=>'*/*').length
    #   assert_not_equal(0, star_all)
    #   assert_not_equal(all, star_all)
    # end

  end

end
