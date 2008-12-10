require File.dirname(__FILE__) + '/../test_helper.rb'

class ResourcesTest < Test::Unit::TestCase

  context "Populated Resources" do 
    
    setup do
      #@db = Cumulus::HashDb.new
      Cumulus::Scanner.new("#{ File.dirname(__FILE__) }/../fixtures/my_site").sweep
    end
    
    should "have found some content collections" do
      assert_not_equal(0, Cumulus::Resources.collections(:collection_type=>'posts').length)
    end

    should "return arrays of content" do
      assert_instance_of(Array, Cumulus::Resources.collections(:collection_type=>'posts'))
      assert_instance_of(Array, Cumulus::Resources.collections(:content_path=>'*/*'))
      assert_instance_of(Array, Cumulus::Resources.collections(:content_path=>'posts/*'))

      assert_equal(1, Cumulus::Resources.collections(:content_path=>'posts/*').length)
    end

    should "return single object of content, optionally" do
      assert_instance_of(Cumulus::Resources::Content, Cumulus::Resources.collections(:first, :collection_type=>'posts'))
    end
    
    should "support wildcard searchs" do
      all = Cumulus::Resources.collections.length
      articles = Cumulus::Resources.collections(:content_path=>'articles/*').length
      assert_not_equal(0, articles)
      assert_not_equal(all, articles)
      
      star_all = Cumulus::Resources.collections(:content_path=>'*/*').length
      assert_not_equal(0, star_all)
      assert_equal(all, star_all)
    end
    
  end

end
