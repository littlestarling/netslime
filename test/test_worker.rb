require 'helper'

class WorkerTest < NetSlime::TestCase
  def setup
    @uri = NetSlime::URI.parse(File.read(TARGET_URI))
    assert @uri.uri?
  end
  
end