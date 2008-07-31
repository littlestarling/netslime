require 'rubygems'
require 'mechanize'

module NetSlime
  class Worker

    def initialize
      @agent = WWW::Mechanize.new
      @agent.user_agent = "NetSlime/0.0.1"
    end

    def crawl (uri)
      page = @agent.get(uri)
    end
  
    def save(uri, path = nil)
      page = @agent.get(uri)
      name = get_file_name(uri)
      path = name if path.nil?
      page.save(path)
    end

    def body(uri)
      page_body = @agent.get(uri).body
    end

  #download files like using wget
    def get_path(uri)
      name = uri.gsub("http://", "")
      dir_list = name.split("/")
      return dir_list
    end

    def get_file_name(uri)
      list = get_path(uri)
      return list.pop.split("\?").first
    end


    def make_all_dirs (uri)
      base_path = Dir.pwd + "/"
      path = ""
      tpath = ""
  #    p "base_path = " + base_path + "¥n"
      dirAry = get_path(uri)
      dirAry.pop #remove filename
      dirAry.each do |dir|
        dir = format_uri(dir)
        tpath = dir + "/"
        path = path + tpath
  #      p "path:" + path
        base_path = base_path + tpath
        unless FileTest.directory? base_path
          Dir.mkdir(base_path)
        end
      end
      path
    end
    
    #transform special characters: ";?:@&=+$!*()%#'" in uri to usable name to file-system
    def format_uri(name)
      name.gsub(/[;?:@&=\+$!*'\(\)%#']/, "_")
    end

    def save_file(uri, path = nil)
      base_path = Dir.pwd
      page = @agent.get(uri)
      name = format_uri(get_file_name(uri))
      path = if path.nil? then name else path + name end
      page.save(base_path + "/" + path)
      path
    end

  end

end
