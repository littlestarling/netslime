require 'rubygems'
require 'mechanize'

module NetSlime
  class Worker

    def initialize
      @agent = WWW::Mechanize.new
    end

    def crawl (uri)
      page = @agent.get(uri)
    end
  
    def save(uri, path = nil)
      page = @agent.get(uri)
      name = get_file_name(uri)
  #    path = Time.now.strftime("%Y%m%d") + name if path.nil?
      path = name if path.nil?
      page.save(path)
    end



    def body(uri)
      page_body = @agent.get(uri).body
    end

  #wget形式でパスを生成する場合のメソッド群
    def get_path(uri)
    # URLパターンを除去
      name = uri.gsub("http://", "")
      dir_list = name.split("/")
      return dir_list
    end

  #filenameだけ拾う
    def get_file_name(uri)
      list = get_path(uri)
      return list.pop
    end


    def make_all_dirs (uri)
      base_path = Dir.pwd + "/"
      path = ""
      tpath = ""
  #    p "base_path = " + base_path + "¥n"
      dirAry = get_path(uri)
      dirAry.pop #remove filename
      dirAry.each do |dir|
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

    def save_file(uri, path = nil)
      base_path = Dir.pwd
      page = @agent.get(uri)
      name = get_file_name(uri)
      path = if path.nil? then name else path + "/" + name end
      page.save(base_path + "/" + path)
      path
    end

  end

end
