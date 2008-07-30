require 'netslime/worker'
require 'netslime/parser'

module NetSlime
  class Dispatcher

    def initialize
      @worker = Worker.new
      @parser = Parser.new
    end

    def parse_data(url, pattern = nil)
      data = @worker.crawl(url)
      result = @parser.analyze(data.body, pattern)
      result
    end

    def get_html(uri, pattern = nil)
      base = uri
      @worker.make_all_dirs(uri)
      list = parse_data(uri, pattern)
      print "debugged. => " + list.inspect
      list.each do |target|
        ilist =[]
        target = base + target unless target.include?("://") # protocol independent
        path = @worker.make_all_dirs(target)
        Dir::chdir(path)
        begin
          @worker.save(target)
          ilist = parse_data(target, "img")
          ilist.each do |i|
            @worker.save(i)
          end
          print "page saved. #{target}"
        rescue => exc
          print exc.to_s + "cannot get uri:" + target
          next
        end
      end
    end
  
    def self.getf(uri, base)
      Dir::chdir(base)
      @worker = Worker.new
      path = @worker.make_all_dirs(uri)
      filepath = @worker.save_file(uri, path)
    end
  end
end
