require 'test/unit'
require 'netslime'

module NetSlime
  class TestCase < Test::Unit::Testcase
    ASSETS_DIR = File.join(File.dirname(__FILE__), 'files')
    TARGET_URL = File.join(ASSETS_DIR, 'urilist.txt')

    undef :default_test
  end
end
